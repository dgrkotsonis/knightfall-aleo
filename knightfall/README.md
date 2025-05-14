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
