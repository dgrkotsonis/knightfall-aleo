#!/bin/bash

# amareleo-chain clean; amareleo-chain start

NETWORK=testnet
ENDPOINT=http://localhost:3030

# Output a .env file, accepts Priavte key as first positional parameter
function write_env_file {
    echo "NETWORK=$NETWORK" > .env
    echo "PRIVATE_KEY=$1" >> .env
    echo "ENDPOINT=$ENDPOINT" >> .env
}

# knightfall
KNIGHTFALL_PRIVATE_KEY=APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH
KNIGHTFALL_VIEW_KEY=AViewKey1mSnpFFC8Mj4fXbK5YiWgZ3mjiV8CxA79bYNa8ymUpTrw
KNIGHTFALL_PUBLIC_KEY=aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px

# White
WHITE_PRIVATE_KEY=APrivateKey1zkp2RWGDcde3efb89rjhME1VYA8QMxcxep5DShNBR6n8Yjh
WHITE_VIEW_KEY=AViewKey1pTzjTxeAYuDpACpz2k72xQoVXvfY4bJHrjeAQp6Ywe5g
WHITE_PUBLIC_KEY=aleo1s3ws5tra87fjycnjrwsjcrnw2qxr8jfqqdugnf0xzqqw29q9m5pqem2u4t

# Black
BLACK_PRIVATE_KEY=APrivateKey1zkp2GUmKbVsuc1NSj28pa1WTQuZaK5f1DQJAT6vPcHyWokG
BLACK_VIEW_KEY=AViewKey1u2X98p6HDbsv36ZQRL3RgxgiqYFr4dFzciMiZCB3MY7A
BLACK_PUBLIC_KEY=aleo1ashyu96tjwe63u0gtnnv8z5lhapdu4l5pjsl2kha7fv7hvz2eqxs5dz0rg

# Write knightfall key to env file
write_env_file $KNIGHTFALL_PRIVATE_KEY

# Build leo program
leo build

# Deploy the leo program
leo deploy --endpoint $ENDPOINT -y
