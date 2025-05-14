#!/bin/bash

#
# Output a .env file, accepts Priavte key as first positional parameter
#
function write_env_file() {
    echo "NETWORK=$NETWORK" > .env
    echo "PRIVATE_KEY=$1" >> .env
    echo "ENDPOINT=$ENDPOINT" >> .env
}

#
# Wait for a transaction to be complete. Transaction ID should be first positional parameter
#
function get_transaction() {
RESPONSE=$($CURL_STATUS_CHECK/$1)
    while [ "$RESPONSE" != "200" ]; do
        # echo "Received $RESPONSE...waiting for transaction to become available..."
        sleep 3
        RESPONSE=$($CURL_STATUS_CHECK/$1)
    done

    curl -sNL $ENDPOINT/$NETWORK/transaction/$1
}

#
# Pretty header
#
function print_header() {

    echo
    echo "---------------------------------------------------------------------"
    printf "%*s\n" $(( ( $(echo $* | wc -c ) + 70 ) / 2 )) "$1"
    echo "---------------------------------------------------------------------"
    echo
}

#
# Let's go
#
print_header "♞ KNIGHTFALL ♘" =
echo "Setting up vars..."

if [ -z "$NETWORK" ]; then
    NETWORK=testnet
    echo "No environment variable called NETWORK, setting to $NETWORK"
else
    echo "NETWORK set by environment to $NETWORK"
fi

if [ -z "$ENDPOINT" ]; then
    ENDPOINT=http://localhost:3030
    echo "No environment variable called ENDPOINT, setting to $ENDPOINT"
else
    echo "ENDPOINT set by environment to $ENDPOINT"
fi

CURL_STATUS_CHECK="curl -s -o /dev/null -I -w "%{http_code}" $ENDPOINT/$NETWORK/transaction"
KNIGHTFALL_PYTHON_REPO_URL=https://github.com/emmaprice082/knightfall

#
# knightfall keys
#
KNIGHTFALL_PRIVATE_KEY=$(cat keys.json | jq -r '.knightfall.private_key')
KNIGHTFALL_VIEW_KEY=$(cat keys.json | jq -r '.knightfall.view_key')
KNIGHTFALL_PUBLIC_KEY=$(cat keys.json | jq -r '.knightfall.public_key')

#
# White keys
#
WHITE_PRIVATE_KEY=$(cat keys.json | jq -r '.white.private_key')
WHITE_VIEW_KEY=$(cat keys.json | jq -r '.white.view_key')
WHITE_PUBLIC_KEY=$(cat keys.json | jq -r '.white.public_key')

#
# Black keys
#
BLACK_PRIVATE_KEY=$(cat keys.json | jq -r '.black.private_key')
BLACK_VIEW_KEY=$(cat keys.json | jq -r '.black.view_key')
BLACK_PUBLIC_KEY=$(cat keys.json | jq -r '.black.public_key')

#
# Clone the python repo
#
echo "Cloning knightfall python repo..."
if [ -d "knightfall-python" ]; then
    echo "Deleting existing git clone..."
    rm -rf knightfall-python
fi
git clone https://github.com/emmaprice082/knightfall knightfall-python

#
# Execute collect_stake as white
#
print_header "♘ Collect Stake ♘"
write_env_file $WHITE_PRIVATE_KEY
echo Initiating game as white...
# echo "leo execute collect_stake $KNIGHTFALL_PUBLIC_KEY $BLACK_PUBLIC_KEY 1u64 -b --endpoint $ENDPOINT --program knightfall"
WHITE_TRANSACTION_ID=$(leo execute collect_stake $KNIGHTFALL_PUBLIC_KEY $BLACK_PUBLIC_KEY 1u64 -b --endpoint $ENDPOINT --program knightfall -y | grep "⌛ Execution" | awk '{print $3}')
echo "Executed collect_stake for white, transaction ID: $WHITE_TRANSACTION_ID, waiting for record to become available"
WHITE_ENCRYPTED_RECORD=$(get_transaction $WHITE_TRANSACTION_ID | jq -r '.execution.transitions[0].outputs[0].value')
echo "Found encrypted record for white: $WHITE_ENCRYPTED_RECORD"

#
# Execute collect_stake as black
#
print_header "♞ Collect Stake ♞"
echo Initiating game as black...
write_env_file $BLACK_PRIVATE_KEY
# echo "leo execute collect_stake $KNIGHTFALL_PUBLIC_KEY $BLACK_PUBLIC_KEY 1u64 -b --endpoint $ENDPOINT --program knightfall"
BLACK_TRANSACTION_ID=$(leo execute collect_stake $KNIGHTFALL_PUBLIC_KEY $BLACK_PUBLIC_KEY 1u64 -b --endpoint $ENDPOINT --program knightfall -y | grep "⌛ Execution" | awk '{print $3}')
echo "Executed collect_stake for black, transaction ID: $BLACK_TRANSACTION_ID, waiting for record to become available"
BLACK_ENCRYPTED_RECORD=$(get_transaction $BLACK_TRANSACTION_ID | jq -r '.execution.transitions[0].outputs[0].value')
echo "Found encrypted record for black: $BLACK_ENCRYPTED_RECORD"

#
# Execute create_game as knightfall
#
print_header "♞ Create Game ♘"
echo Creating game...
write_env_file $KNIGHTFALL_PRIVATE_KEY
# echo "leo execute create_game $KNIGHTFALL_PUBLIC_KEY "$(snarkos developer decrypt --network 1 -c $WHITE_ENCRYPTED_RECORD -v $KNIGHTFALL_VIEW_KEY)" "$(snarkos developer decrypt --network 1 -c $BLACK_ENCRYPTED_RECORD -v $KNIGHTFALL_VIEW_KEY)" -b --endpoint $ENDPOINT --program knightfall"
GAME_TRANSACTION_ID=$(leo execute create_game $KNIGHTFALL_PUBLIC_KEY "$(snarkos developer decrypt --network 1 -c $WHITE_ENCRYPTED_RECORD -v $KNIGHTFALL_VIEW_KEY)" "$(snarkos developer decrypt --network 1 -c $BLACK_ENCRYPTED_RECORD -v $KNIGHTFALL_VIEW_KEY)" -b --endpoint $ENDPOINT --program knightfall -y | grep "⌛ Execution" | awk '{print $3}')
echo "Executed create_game, transaction ID: $GAME_TRANSACTION_ID"
GAME_ENCRYPTED_RECORD=$(get_transaction $GAME_TRANSACTION_ID | jq -r '.execution.transitions[0].outputs[0].value')
echo "Found encrypted record for game: $GAME_ENCRYPTED_RECORD"

#
# Run the test script in knightfall-python
#
print_header "♞ Play Game ♘"
echo "Executing the Fool's Mate test game..."
GAME_RESULT=$(python knightfall-python/test.py --two $WHITE_PUBLIC_KEY $BLACK_PUBLIC_KEY | tail -n1)
WINNER=$(echo "$GAME_RESULT" | jq -r '.winner_address')
LOSER=$(echo "$GAME_RESULT" | jq -r '.loser_address')
echo "Broadcasting the game result, winner record: $WINNER, loser record: $LOSER"
FINISH_TRANSACTION_ID=$(leo execute finish_game $WINNER $LOSER -b --endpoint $ENDPOINT --program knightfall -y | grep "⌛ Execution" | awk '{print $3}')
echo "Executed finish_game, transaction ID: $FINISH_TRANSACTION_ID"
FINISH_ENCRYPTED_RECORD=$(get_transaction $FINISH_TRANSACTION_ID | jq -r '.execution.transitions[0].outputs[0].value')
echo "Found encrypted record for finished game: $FINISH_ENCRYPTED_RECORD"
echo

#
# Display final board state
#
print_header "♞ Final Board State ♘"
cat .white.board
