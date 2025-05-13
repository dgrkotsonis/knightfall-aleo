// The 'knightfall' program.
program knightfall.aleo {

    // Note: Need additional fields?
    record PlayerRecord {
        owner: address,
        games_won: u32,
        games_played: u32,
    }

    record GameOutcomeSignature {
        winner: address,
        loser: address,
        winner_signed: bool,
        loser_signed: bool,
    }

    // NOTE: Is there some way to ensure that a single user
    // doesn't just keep generating new records?
    transition generate_record(
        player: address
    ) -> PlayerRecord {
        // Possible to check existing records here or no?

        return PlayerRecord {
            owner: player,
            games_won: 0u32,
            games_played: 0u32
        }
    }

    transition generate_signature(
        winner: address,
        loser: address,
        signatures: u8
    ) -> GameOutcomeSignature {

        let winner_signed: bool = (signatures & 1u8) != 0u8; // bit 0 
        let loser_signed: bool = (signatures & 2u8) != 0u8; // bit 01

        // 
        return GameOutcomeSignature {
            winner: winner,
            loser: loser,
            winner_signed: winner_signed,
            loser_signed: loser_signed,
        }
    }

    // TODO:

    // Can they each provide a credits.aleo record to submit as wager???
    transition initiate_game(
        player_1: PlayerRecord,
        player_2: PlayerRecord,
        player_1_wager: u64,
        player_2_wager: u64,
    ) -> bool {
        return true
    }

    transition end_game(
        player_1_signature: 
    )

    transition main(public a: u32, b: u32) -> u32 {
        let c: u32 = a + b;
        return c;
    }
}
