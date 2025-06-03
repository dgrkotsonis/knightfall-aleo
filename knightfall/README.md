# knightfall.aleo

## Some suggestions
Not completely checking validity. For instance pawn_move_advance will allow the pawn to advance even if the square it's advancing to is occupied.
Can first define a struct Board for convenience:
```
struct Board {
  x: [field; 32],
  y: [field; 32],
}
```
eliminate manually passing around both halves of the board. 

Then define a function or inline to access items at squares by row and column:
```
function access(board: Board, row: i8, col: i8) -> field {
    ...
}
```
And have it return a specified value if row and col are out of bounds, maybe just -1field.

Then when checking for a horizontal rook move, could do something like this
// Suppose we have from_row, from_col representing the rook's current position, and we want to check in one direction, and to_row, to_col
// is the square we're trying to move to.
```
for i: i8 in 0i8..8i8 {
    let next_col: i8 = from_col + i;
    let piece = access(board, from_row, next_col);
    if from_row == to_row && next_col == to_col {
        // If the `piece` is empty or the opponent's piece, do the move.
        // Otherwise, the move is invalid. 
        // ......
    } else {
        // If the `piece` is occupied or off the board, moving this direction isn't going to work. 
        // If the `piece` is just empty, we're still OK.
    }
}
```

And then check for all 4 possible directions like this. 

The tricky part is that program can't break out of the loop like a normal programming language, but can return from inside it.

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

To test pawn movement logic:
`leo run test_pawn_two_squares 0u8`
`leo run test_pawn_two_squares 0u8`

To test king movement logic:
`leo run test_king_move_only 0u8`

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

## Off-Chain Tests

Example: 
# Suppose you have a function to call Leo transitions and get the output:
def get_square_value(idx):
    # Call: leo run get_square_value 0u8 <idx>
    # Parse and return the output (as int or string)
    ...

# Set up your board in Leo, then:
pawn_square = get_square_value(36)  # e4
target_square = get_square_value(27)  # d5

# Off-chain logic:
if pawn_square == 11 and target_square == 1:
    # Check if move is a valid diagonal capture
    print("Valid capture!")
else:
    print("Invalid capture.")