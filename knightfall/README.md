# knightfall.aleo

## Build Guide

To compile this Aleo program, run:
```bash
snarkvm build
```

To execute this Aleo program, run:
```bash
snarkvm run knightfall
```

## Some Local Commands

To compile this Aleo program, run:
`leo build`

To test the `collect_stake` function, run: 
-TODO-

To test the `create_game` function, run: 
-TODO-

To test the `finish_game` function, run: 
-TODO-

## Running the Fool's Mate Example Locally

### LOCAL NODE

We can run the Fool's Mate script locally to test using [amareleo-chain](https://github.com/kaxxa123/amareleo-chain). Follow the [installation instructions](https://github.com/kaxxa123/amareleo-chain?tab=readme-ov-file#22-install-from-source) and then spin up a node:

```bash
amareleo-chain start
```

If you want to restart the chain (to test redeployment, for example), run:

```bash
amareleo-chain clean; amareleo-chain start
```

### KEYS

The test script requires three Aleo accounts: one for the knightfall python engine and one for each player. It's recommended to use the example keys with amareleo-chain since they have a lot of credits. Copy the `keys.json.example` file to `keys.json` (or add the keys you want to use to a `keys.json` file).

### DEPLOY THE PROGRAM

Now we can deploy the program to our local node. You should be able to simply run the script and answer the prompt:

```bash
./deploy-program.sh
```

If, for some reason, you want to use a different endpoint or network, you can define them as environment variables:

```bash
export NETWORK=testnet
export ENDPOINT=http://localhost:3030
```

### RUNNING THE SCRIPT

Generally speaking you should now be able to run the script as-is:
```bash
./run-fools-mate.sh
```

If, for some reason, you want to use a different endpoint or network, you can define them as environment variables:

```bash
export NETWORK=testnet
export ENDPOINT=http://localhost:3030
```

The script will:
* Execute the `collect_stake` function as white
* Execute the `collect_stake` function as black
* Execute the `create_game` function as the knightfall engine
* Execute a series of moves against the knightfall engine to play the game. In the future these moves could be done via leo functions as well
* Once the game is complete, the `finish_game` function is executed and the final board state is displayed


## On Chain

```bash
# Execute `collect_stake`
leo execute collect_stake \
    aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px \
    aleo1ashyu96tjwe63u0gtnnv8z5lhapdu4l5pjsl2kha7fv7hvz2eqxs5dz0rg \
    1u64 \
    -b --endpoint http://localhost:3030 --program knightfall
```

```bash
# Execute `create_game`
leo execute create_game aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px "{
        owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.private,
        player_address: aleo1s3ws5tra87fjycnjrwsjcrnw2qxr8jfqqdugnf0xzqqw29q9m5pqem2u4t.private,
        opponent_address: aleo1ashyu96tjwe63u0gtnnv8z5lhapdu4l5pjsl2kha7fv7hvz2eqxs5dz0rg.private,
        amount: 1u64.private,
        _nonce: 2820034930857370665039594023810830007337169179662236151994194094746132137867group.public 
    }"  "{ 
        owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.private,player_address: aleo1ashyu96tjwe63u0gtnnv8z5lhapdu4l5pjsl2kha7fv7hvz2eqxs5dz0rg.private,
        opponent_address: aleo1ashyu96tjwe63u0gtnnv8z5lhapdu4l5pjsl2kha7fv7hvz2eqxs5dz0rg.private,
        amount: 1u64.private,
        _nonce: 5525759172236317056254609959218622800331808908231474460568803993892218953813group.public 
    }" -b --endpoint http://localhost:3030 --program knightfall
```
