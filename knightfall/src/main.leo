// The 'knightfall' program.
program knightfall.aleo {

    // Note: 
    // 1. make into a mapping so we can look this up
    // 2. sum on chain records in dapp and send that sum to this program before create_game
    record PlayerRecord {
        owner: address,
        games_won: u32,
        games_played: u32,
    }

    record GameOutcomeSignature {
        winner: address,
        loser: address,
        // transcript: u64, not sure what type ??
        // winner_signed: bool,
        // loser_signed: bool,
    }

    record GameRequest {
        owner: address,
        player_address: address,
        opponent_address: address,
        amount: u64,
    }

    record GameRecord {
        owner: address,
        player_one: address,
        player_two: address,
        winnings: u64,
    }

    // collect_stake, take opponent_address as input and amount for the game (from Python Script)
    transition collect_stake(owner_address: address, opponent_address: address, amount: u64) -> GameRequest {
        // Creates new Game Request
        // owner address: aleo1vcg3xac7ssx2lx6x4ypcnyv53n0yntqcd5p4l6kravajtlnh5cysryyya3
        return GameRequest {
            owner: owner_address,
            player_address: self.caller,
            opponent_address,
            amount: amount,
        };
    }

    // create_game should take in 2 record inputs, check they both staked the amount, and then create a GameRecord
    transition create_game(owner_address: address, player_one: GameRequest, player_two: GameRequest) -> GameRecord {
        // Ensure the caller is the auctioneer.
        assert_eq(player_one.amount, player_two.amount);

        return GameRecord {
                owner_address: address,
                player_one.player_address: address,
                player_two.player_address: address,
                winnings: player_one.amount + player_two.amount,
            };
    }

    // Python takes the game record and does game play
    //      sends signal that then triggers end_game function
    //      have this update the mapping

    // inline calculate_games_won() -> PlayerRecord {
    //     record PlayerRecord {
    //             owner: player_one,
    //             games_won: u32,
    //             games_played: u32,
    //         }
    // }

    transition finish_game(winner: address, loser: address, player_one: address, player_two: address) -> GameOutcomeSignature, PlayerRecord, PlayerRecord {
        
        // TODO: update calculate_games_won to output new PlayerRecord for each player
        
        let game_outcome = GameOutcomeSignature {
            winner: winner,
            loser: loser,
            // transcript: u64, not sure what type ??
            // winner_signed: bool,
            // loser_signed: bool,
        }

        let player_one_rank = PlayerRecord {
            owner: player_one,
            games_won: false, // setting to false right now, so it means nothing, can change once we have a helper to calculate
            games_played: false,
        }

        let player_two_rank = PlayerRecord {
            owner: player_two,
            games_won: false, // setting to false right now, so it means nothing, can change once we have a helper to calculate
            games_played: false,
        }

        return (game_outcome, player_one_rank, player_two_rank)
        
    }

}
