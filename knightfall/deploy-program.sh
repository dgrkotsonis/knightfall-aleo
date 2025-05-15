#!/bin/bash

# amareleo-chain clean; amareleo-chain start

# Output a .env file, accepts Priavte key as first positional parameter
function write_env_file {
    echo "NETWORK=$NETWORK" > .env
    echo "PRIVATE_KEY=$1" >> .env
    echo "ENDPOINT=$ENDPOINT" >> .env
}

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

#
# knightfall keys
#
KNIGHTFALL_PRIVATE_KEY=$(cat keys.json | jq -r '.knightfall.private_key')
KNIGHTFALL_VIEW_KEY=$(cat keys.json | jq -r '.knightfall.view_key')
KNIGHTFALL_PUBLIC_KEY=$(cat keys.json | jq -r '.knightfall.public_key')

# Write knightfall key to env file
write_env_file $KNIGHTFALL_PRIVATE_KEY

# Deploy the leo program
leo deploy --endpoint $ENDPOINT
