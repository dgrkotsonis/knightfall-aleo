// The 'knightfall' program.
program knightfall.aleo {

    // On-chain storage of the players `ranks` map, with `address` as the key,
    // and `u64` as the value.
    mapping ranks: address => rank_data;
    struct rank_data{
        games_won: u64,
        games_played: u64,
    }


    // TODO: don't need unless we want players to have something they take away 
    // from the game, like a trophy
    // record GameOutcomeSignature {
    //     owner: address,
    //     winner: address,
    //     loser: address,
    //     transcript: u64, // not sure what type ??
    //     winner_signed: bool, // needed?
    //     loser_signed: bool, // needed?
    // }

    record GameRequest {
        owner: address,
        player_address: address,
        opponent_address: address,
        amount: u64, // TODO: start with 1 ALEO, can modify later
    }

    record GameRecord {
        owner: address,
        player_one: address,
        player_two: address,
        winnings: u64, // TODO: both players have to stake the same amount 
                       // currently for game to start 
    }

    // collect_stake, take opponent_address as input and amount for the game 
    // (from Python Script)
    transition collect_stake(owner_address: address, opponent_address: address, amount: u64) -> GameRequest {
        // Creates new Game Request
        // owner address in this case is the program: 
        // aleo1vcg3xac7ssx2lx6x4ypcnyv53n0yntqcd5p4l6kravajtlnh5cysryyya3
        return GameRequest {
            owner: owner_address,
            player_address: self.caller,
            opponent_address: opponent_address,
            amount: amount,
        };
    }

    // create_game should take in 2 record inputs, check they both staked the amount, 
    // and then create a GameRecord
    transition create_game(owner_address: address, player_one: GameRequest, player_two: GameRequest) -> GameRecord {
        // Ensure the players staked the same amount.
        // TODO: remove if we decide to "charge" entry based on rank/expertise
        assert_eq(player_one.amount, player_two.amount);

        return GameRecord {
            owner: owner_address,
            player_one: player_one.player_address, // first to move (Chess: White)
            player_two: player_two.player_address, // second to move (Chess: Bhite)
            winnings: player_one.amount + player_two.amount,
        };
    }

    // Python takes the game record and does game play
    //      in charge of validating moves & board visibility
    //      sends signal that then triggers finish_game function
    //      finish_game updates the mapping of each player's rank

    // TODO: write function to use elo algorithm (for Chess)
    // inline ranking()

    // Using a public mapping (i.e. executed on chain) for player's rank
    // async functions are public (i.e. executed on chain) whether values are declared public or not
    async function finalize_rank_public(public winner_address: address, public loser_address: address, public increment: u64) {
        // Increments `rank[player_address]` by `increment`.
        // If `rank[player_address]` does not exist, it will be created.

        // update struct for winner
        let winner_rank: rank_data = Mapping::get_or_use(ranks, winner_address, rank_data{
            games_won: 0u64,
            games_played: 0u64
        }); // sets 0 if there is no address (player_address)
        
        // winner - assign rank_data values for ranks mapping)
        let new_winner_data: rank_data = rank_data{
            games_won: winner_rank.games_won + increment, // change to have elo calculated here
            games_played: winner_rank.games_played + 1u64 // can only ever get +1 increment
        };

        // update struct for loser
        let loser_rank: rank_data = Mapping::get_or_use(ranks, loser_address, rank_data{
            games_won: 0u64,
            games_played: 0u64
        }); // sets 0 if there is no address (player_address)
        
        // loser - assign rank_data values for ranks mapping)
        let new_loser_data: rank_data = rank_data{
            games_won: loser_rank.games_won, // don't increment for loser, change to have elo calculated here
            games_played: loser_rank.games_played + 1u64 // can only ever get +1 increment
        };
        
        Mapping::set(ranks, winner_address, new_winner_data);
        Mapping::set(ranks, loser_address, new_loser_data);

    }

    // listening from our python script
    async transition finish_game(winner: address, loser: address) -> Future {
        
        // TODO: modify the increment value based on player expertise/rank
        // could penalize expert players for losing to lowwer ranked players
        let increment: u64 = 1u64;

        let player_ranks: Future = finalize_rank_public(winner, loser, increment);

        return player_ranks;
        
    }

    // TODO: add function to handle draws, split the fee between 2 players, 
    //  return remaining between both players (either 50/50 or by rank)
    // async transition finish_game_draw

}
