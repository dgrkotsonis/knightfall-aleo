// The 'knightfall' program.
program provable_toronoto25_knightfall.aleo {

    ////////////////////////////////////////////////////////////////////////////////////
    //                               CONFIGURATION                                    //
    ////////////////////////////////////////////////////////////////////////////////////

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

    ////////////////////////////////////////////////////////////////////////////////////
    //                               START GAME                                       //
    ////////////////////////////////////////////////////////////////////////////////////

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

    ////////////////////////////////////////////////////////////////////////////////////
    //                             HELPER FUNCTIONS                                   //
    ////////////////////////////////////////////////////////////////////////////////////

    inline get_array_value(arr: [field; 32], idx: u32) -> field {
        let v0: field = (idx == 0u32) ? arr[0u32] : 0field;
        let v1: field = (idx == 1u32) ? arr[1u32] : v0;
        let v2: field = (idx == 2u32) ? arr[2u32] : v1;
        let v3: field = (idx == 3u32) ? arr[3u32] : v2;
        let v4: field = (idx == 4u32) ? arr[4u32] : v3;
        let v5: field = (idx == 5u32) ? arr[5u32] : v4;
        let v6: field = (idx == 6u32) ? arr[6u32] : v5;
        let v7: field = (idx == 7u32) ? arr[7u32] : v6;
        let v8: field = (idx == 8u32) ? arr[8u32] : v7;
        let v9: field = (idx == 9u32) ? arr[9u32] : v8;
        let v10: field = (idx == 10u32) ? arr[10u32] : v9;
        let v11: field = (idx == 11u32) ? arr[11u32] : v10;
        let v12: field = (idx == 12u32) ? arr[12u32] : v11;
        let v13: field = (idx == 13u32) ? arr[13u32] : v12;
        let v14: field = (idx == 14u32) ? arr[14u32] : v13;
        let v15: field = (idx == 15u32) ? arr[15u32] : v14;
        let v16: field = (idx == 16u32) ? arr[16u32] : v15;
        let v17: field = (idx == 17u32) ? arr[17u32] : v16;
        let v18: field = (idx == 18u32) ? arr[18u32] : v17;
        let v19: field = (idx == 19u32) ? arr[19u32] : v18;
        let v20: field = (idx == 20u32) ? arr[20u32] : v19;
        let v21: field = (idx == 21u32) ? arr[21u32] : v20;
        let v22: field = (idx == 22u32) ? arr[22u32] : v21;
        let v23: field = (idx == 23u32) ? arr[23u32] : v22;
        let v24: field = (idx == 24u32) ? arr[24u32] : v23;
        let v25: field = (idx == 25u32) ? arr[25u32] : v24;
        let v26: field = (idx == 26u32) ? arr[26u32] : v25;
        let v27: field = (idx == 27u32) ? arr[27u32] : v26;
        let v28: field = (idx == 28u32) ? arr[28u32] : v27;
        let v29: field = (idx == 29u32) ? arr[29u32] : v28;
        let v30: field = (idx == 30u32) ? arr[30u32] : v29;
        let v31: field = (idx == 31u32) ? arr[31u32] : v30;
        return v31;
    }

    inline set_array_value(arr: [field; 32], idx: u32, val: field) -> [field; 32] {
        return [
            (idx == 0u32) ? val : arr[0u32],
            (idx == 1u32) ? val : arr[1u32],
            (idx == 2u32) ? val : arr[2u32],
            (idx == 3u32) ? val : arr[3u32],
            (idx == 4u32) ? val : arr[4u32],
            (idx == 5u32) ? val : arr[5u32],
            (idx == 6u32) ? val : arr[6u32],
            (idx == 7u32) ? val : arr[7u32],
            (idx == 8u32) ? val : arr[8u32],
            (idx == 9u32) ? val : arr[9u32],
            (idx == 10u32) ? val : arr[10u32],
            (idx == 11u32) ? val : arr[11u32],
            (idx == 12u32) ? val : arr[12u32],
            (idx == 13u32) ? val : arr[13u32],
            (idx == 14u32) ? val : arr[14u32],
            (idx == 15u32) ? val : arr[15u32],
            (idx == 16u32) ? val : arr[16u32],
            (idx == 17u32) ? val : arr[17u32],
            (idx == 18u32) ? val : arr[18u32],
            (idx == 19u32) ? val : arr[19u32],
            (idx == 20u32) ? val : arr[20u32],
            (idx == 21u32) ? val : arr[21u32],
            (idx == 22u32) ? val : arr[22u32],
            (idx == 23u32) ? val : arr[23u32],
            (idx == 24u32) ? val : arr[24u32],
            (idx == 25u32) ? val : arr[25u32],
            (idx == 26u32) ? val : arr[26u32],
            (idx == 27u32) ? val : arr[27u32],
            (idx == 28u32) ? val : arr[28u32],
            (idx == 29u32) ? val : arr[29u32],
            (idx == 30u32) ? val : arr[30u32],
            (idx == 31u32) ? val : arr[31u32]
        ];
    }

    // Inline function to simulate dynamic indexing
    inline index_into_array(xs: [field; 8], index: u32) -> field {
        let result0: field = 0field;
        let result1: field = (0u32 == index) ? xs[0u32] : result0;
        let result2: field = (1u32 == index) ? xs[1u32] : result1;
        let result3: field = (2u32 == index) ? xs[2u32] : result2;
        let result4: field = (3u32 == index) ? xs[3u32] : result3;
        let result5: field = (4u32 == index) ? xs[4u32] : result4;
        let result6: field = (5u32 == index) ? xs[5u32] : result5;
        let result7: field = (6u32 == index) ? xs[6u32] : result6;
        let result8: field = (7u32 == index) ? xs[7u32] : result7;
        return result8;
    }

    // Inline function to move a piece within a 32-element array
    inline move_in_array(arr: [field; 32], from: u32, to: u32, piece: field) -> [field; 32] {
        let arr0: [field; 32] = arr;
        let arr1: [field; 32] = [
            (0u32 == from) ? 0field : (0u32 == to) ? piece : arr0[0u32],
            (1u32 == from) ? 0field : (1u32 == to) ? piece : arr0[1u32],
            (2u32 == from) ? 0field : (2u32 == to) ? piece : arr0[2u32],
            (3u32 == from) ? 0field : (3u32 == to) ? piece : arr0[3u32],
            (4u32 == from) ? 0field : (4u32 == to) ? piece : arr0[4u32],
            (5u32 == from) ? 0field : (5u32 == to) ? piece : arr0[5u32],
            (6u32 == from) ? 0field : (6u32 == to) ? piece : arr0[6u32],
            (7u32 == from) ? 0field : (7u32 == to) ? piece : arr0[7u32],
            (8u32 == from) ? 0field : (8u32 == to) ? piece : arr0[8u32],
            (9u32 == from) ? 0field : (9u32 == to) ? piece : arr0[9u32],
            (10u32 == from) ? 0field : (10u32 == to) ? piece : arr0[10u32],
            (11u32 == from) ? 0field : (11u32 == to) ? piece : arr0[11u32],
            (12u32 == from) ? 0field : (12u32 == to) ? piece : arr0[12u32],
            (13u32 == from) ? 0field : (13u32 == to) ? piece : arr0[13u32],
            (14u32 == from) ? 0field : (14u32 == to) ? piece : arr0[14u32],
            (15u32 == from) ? 0field : (15u32 == to) ? piece : arr0[15u32],
            (16u32 == from) ? 0field : (16u32 == to) ? piece : arr0[16u32],
            (17u32 == from) ? 0field : (17u32 == to) ? piece : arr0[17u32],
            (18u32 == from) ? 0field : (18u32 == to) ? piece : arr0[18u32],
            (19u32 == from) ? 0field : (19u32 == to) ? piece : arr0[19u32],
            (20u32 == from) ? 0field : (20u32 == to) ? piece : arr0[20u32],
            (21u32 == from) ? 0field : (21u32 == to) ? piece : arr0[21u32],
            (22u32 == from) ? 0field : (22u32 == to) ? piece : arr0[22u32],
            (23u32 == from) ? 0field : (23u32 == to) ? piece : arr0[23u32],
            (24u32 == from) ? 0field : (24u32 == to) ? piece : arr0[24u32],
            (25u32 == from) ? 0field : (25u32 == to) ? piece : arr0[25u32],
            (26u32 == from) ? 0field : (26u32 == to) ? piece : arr0[26u32],
            (27u32 == from) ? 0field : (27u32 == to) ? piece : arr0[27u32],
            (28u32 == from) ? 0field : (28u32 == to) ? piece : arr0[28u32],
            (29u32 == from) ? 0field : (29u32 == to) ? piece : arr0[29u32],
            (30u32 == from) ? 0field : (30u32 == to) ? piece : arr0[30u32],
            (31u32 == from) ? 0field : (31u32 == to) ? piece : arr0[31u32]
        ];
        return arr1;
    }

    inline get_board_index(idx: u32) -> u32 {
        return (idx == 0u32)  ? 0u32
            : (idx == 1u32)  ? 1u32
            : (idx == 2u32)  ? 2u32
            : (idx == 3u32)  ? 3u32
            : (idx == 4u32)  ? 4u32
            : (idx == 5u32)  ? 5u32
            : (idx == 6u32)  ? 6u32
            : (idx == 7u32)  ? 7u32
            : (idx == 8u32)  ? 8u32
            : (idx == 9u32)  ? 9u32
            : (idx == 10u32) ? 10u32
            : (idx == 11u32) ? 11u32
            : (idx == 12u32) ? 12u32
            : (idx == 13u32) ? 13u32
            : (idx == 14u32) ? 14u32
            : (idx == 15u32) ? 15u32
            : (idx == 16u32) ? 16u32
            : (idx == 17u32) ? 17u32
            : (idx == 18u32) ? 18u32
            : (idx == 19u32) ? 19u32
            : (idx == 20u32) ? 20u32
            : (idx == 21u32) ? 21u32
            : (idx == 22u32) ? 22u32
            : (idx == 23u32) ? 23u32
            : (idx == 24u32) ? 24u32
            : (idx == 25u32) ? 25u32
            : (idx == 26u32) ? 26u32
            : (idx == 27u32) ? 27u32
            : (idx == 28u32) ? 28u32
            : (idx == 29u32) ? 29u32
            : (idx == 30u32) ? 30u32
            : (idx == 31u32) ? 31u32
            : (idx == 32u32) ? 0u32
            : (idx == 33u32) ? 1u32
            : (idx == 34u32) ? 2u32
            : (idx == 35u32) ? 3u32
            : (idx == 36u32) ? 4u32
            : (idx == 37u32) ? 5u32
            : (idx == 38u32) ? 6u32
            : (idx == 39u32) ? 7u32
            : (idx == 40u32) ? 8u32
            : (idx == 41u32) ? 9u32
            : (idx == 42u32) ? 10u32
            : (idx == 43u32) ? 11u32
            : (idx == 44u32) ? 12u32
            : (idx == 45u32) ? 13u32
            : (idx == 46u32) ? 14u32
            : (idx == 47u32) ? 15u32
            : (idx == 48u32) ? 16u32
            : (idx == 49u32) ? 17u32
            : (idx == 50u32) ? 18u32
            : (idx == 51u32) ? 19u32
            : (idx == 52u32) ? 20u32
            : (idx == 53u32) ? 21u32
            : (idx == 54u32) ? 22u32
            : (idx == 55u32) ? 23u32
            : (idx == 56u32) ? 24u32
            : (idx == 57u32) ? 25u32
            : (idx == 58u32) ? 26u32
            : (idx == 59u32) ? 27u32
            : (idx == 60u32) ? 28u32
            : (idx == 61u32) ? 29u32
            : (idx == 62u32) ? 30u32
            : (idx == 63u32) ? 31u32
            : 0u32; // fallback, should never be hit if input is valid
    }

    // Main function to move a piece
    function move_piece(
        board1: [field; 32],
        board2: [field; 32],
        from: u32,
        to: u32
    ) -> ([field; 32], [field; 32]) {
        // Ensure indices are in range
        assert(from < 64u32);
        assert(to < 64u32);

        // Determine which array and index for from/to
        let from_arr: u8 = (from < 32u32) ? 1u8 : 2u8;
        let to_arr: u8 = (to < 32u32) ? 1u8 : 2u8;
        let from_idx: u32 = get_board_index(from);
        let to_idx: u32 = get_board_index(to);

        // Get the piece to move
        let piece: field = (from_arr == 1u8) ? get_array_value(board1, from_idx) : get_array_value(board2, from_idx);

        // Remove piece from source and place at destination
        let new_board1: [field; 32] = (from_arr == 1u8 && to_arr == 1u8)
            ? set_array_value(set_array_value(board1, from_idx, 0field), to_idx, piece)
            : (from_arr == 1u8 && to_arr == 2u8)
                ? set_array_value(board1, from_idx, 0field)
                : (from_arr == 2u8 && to_arr == 1u8)
                    ? set_array_value(board1, to_idx, piece)
                    : board1;

        let new_board2: [field; 32] = (from_arr == 2u8 && to_arr == 2u8)
            ? set_array_value(set_array_value(board2, from_idx, 0field), to_idx, piece)
            : (from_arr == 2u8 && to_arr == 1u8)
                ? set_array_value(board2, from_idx, 0field)
                : (from_arr == 1u8 && to_arr == 2u8)
                    ? set_array_value(board2, to_idx, piece)
                    : board2;

        return (new_board1, new_board2);
    }

    // function that checks if the king still exists
    inline contains_piece(arr: [field; 32], piece: field) -> bool {
        let found0: bool = arr[0u32] == piece;
        let found1: bool = found0 || (arr[1u32] == piece);
        let found2: bool = found1 || (arr[2u32] == piece);
        let found3: bool = found2 || (arr[3u32] == piece);
        let found4: bool = found3 || (arr[4u32] == piece);
        let found5: bool = found4 || (arr[5u32] == piece);
        let found6: bool = found5 || (arr[6u32] == piece);
        let found7: bool = found6 || (arr[7u32] == piece);
        let found8: bool = found7 || (arr[8u32] == piece);
        let found9: bool = found8 || (arr[9u32] == piece);
        let found10: bool = found9 || (arr[10u32] == piece);
        let found11: bool = found10 || (arr[11u32] == piece);
        let found12: bool = found11 || (arr[12u32] == piece);
        let found13: bool = found12 || (arr[13u32] == piece);
        let found14: bool = found13 || (arr[14u32] == piece);
        let found15: bool = found14 || (arr[15u32] == piece);
        let found16: bool = found15 || (arr[16u32] == piece);
        let found17: bool = found16 || (arr[17u32] == piece);
        let found18: bool = found17 || (arr[18u32] == piece);
        let found19: bool = found18 || (arr[19u32] == piece);
        let found20: bool = found19 || (arr[20u32] == piece);
        let found21: bool = found20 || (arr[21u32] == piece);
        let found22: bool = found21 || (arr[22u32] == piece);
        let found23: bool = found22 || (arr[23u32] == piece);
        let found24: bool = found23 || (arr[24u32] == piece);
        let found25: bool = found24 || (arr[25u32] == piece);
        let found26: bool = found25 || (arr[26u32] == piece);
        let found27: bool = found26 || (arr[27u32] == piece);
        let found28: bool = found27 || (arr[28u32] == piece);
        let found29: bool = found28 || (arr[29u32] == piece);
        let found30: bool = found29 || (arr[30u32] == piece);
        let found31: bool = found30 || (arr[31u32] == piece);
        return found31;
    }

    ////////////////////////////////////////////////////////////////////////////////////
    //                              MOVE VALIDATION                                   //
    ////////////////////////////////////////////////////////////////////////////////////

    // PAWN //
    // TODO: En passant capture not implemented - requires tracking last move state
    // TODO: Promotion detection not integrated with move validation - needs coordination with pawn_move_promotion()
    inline is_white_pawn_first_move(idx: u32) -> bool {
        // White pawns start at rank 2: indices 48–55
        return (idx >= 48u32) && (idx <= 55u32);
    }

    inline is_black_pawn_first_move(idx: u32) -> bool {
        // Black pawns start at rank 7: indices 8–15
        return (idx >= 8u32) && (idx <= 15u32);
    }

    // TODO: used?
    inline is_white_pawn_promotion(idx: u32) -> bool {
        // White promotion: rank 8, indices 0–7
        return (idx <= 7u32);
    }

    // TODO: used?
    inline is_black_pawn_promotion(idx: u32) -> bool {
        // Black promotion: rank 1, indices 56–63
        return (idx >= 56u32) && (idx <= 63u32);
    }

    // ex white pawn: let can_advance: bool = pawn_move_advance(board1, 52i32, 36i32, -8i32, true); // f2 to f4 (first move, two squares)
    inline pawn_move_advance(
        board1: [field; 32],
        from: i32,
        to: i32,
        dir: i32,
        is_white: bool
    ) -> bool {
        // One square forward
        let one_forward: bool = to == from + dir;

        // Two squares forward on first move
        let from_u32: u32 = from as u32;
        let two_forward: bool = is_white
            ? (is_white_pawn_first_move(from_u32) && to == from + 2i32 * dir)
            : (is_black_pawn_first_move(from_u32) && to == from + 2i32 * dir);

        return one_forward || two_forward;
    }

    inline pawn_move_capture(
        board1: [field; 32],
        board2: [field; 32],
        from: i32,
        to: i32,
        dir: i32
    ) -> bool {
        // Get destination piece
        let to_arr: u8 = (to < 32i32) ? 1u8 : 2u8;
        let to_idx: u32 = get_board_index(to as u32);
        let dest_piece: field = (to_arr == 1u8) ? get_array_value(board1, to_idx) : get_array_value(board2, to_idx);

        // Diagonal left
        let diag_left: bool = (to == from + dir - 1i32) && (dest_piece != 0field);
        // Diagonal right
        let diag_right: bool = (to == from + dir + 1i32) && (dest_piece != 0field);

        return diag_left || diag_right;
    }

    // Example: Black pawn moves to a1 (index 56)
    // let (board1b, board2c) = pawn_move_promotion(board1a, board2b, 56u32, false, 5field); // promote to queen
    // NOTE: This function handles the promotion AFTER the move is made
    // TODO: Integrate promotion detection with pawn_move_or_capture_logic() for complete validation
    inline pawn_move_promotion(
        board1: [field; 32],
        board2: [field; 32],
        to: u32,
        is_white: bool,
        promote_to: field // 5field=queen, 4field=bishop, 3field=knight, 2field=rook
    ) -> ([field; 32], [field; 32]) {
        // Determine which array and index for 'to'
        let to_arr: u8 = (to < 32u32) ? 1u8 : 2u8;
        let to_idx: u32 = get_board_index(to);

        // Check if promotion square
        let is_promotion: bool = is_white
            ? (to <= 7u32)
            : (to >= 56u32 && to <= 63u32);

        // If promotion, set the promoted piece; else, leave as is
        let new_board1: [field; 32] = (to_arr == 1u8 && is_promotion)
            ? set_array_value(board1, to_idx, promote_to)
            : board1;

        let new_board2: [field; 32] = (to_arr == 2u8 && is_promotion)
            ? set_array_value(board2, to_idx, promote_to)
            : board2;

        return (new_board1, new_board2);
    }

    // Unified pawn validation function (combines advance and capture)
    inline pawn_move_or_capture_logic(
        from: u32,
        to: u32,
        board1: [field; 32],
        board2: [field; 32],
        is_white: bool
    ) -> bool {
        // Convert to i32 for arithmetic
        let from_i32: i32 = from as i32;
        let to_i32: i32 = to as i32;
        
        // Pawn direction: white moves up (negative), black moves down (positive)
        let direction: i32 = is_white ? -8i32 : 8i32;
        
        // Get destination piece
        let to_arr: u8 = (to < 32u32) ? 1u8 : 2u8;
        let to_idx: u32 = get_board_index(to);
        let dest_piece: field = (to_arr == 1u8) ? get_array_value(board1, to_idx) : get_array_value(board2, to_idx);
        
        // Calculate row and column
        let from_row: i32 = from_i32 / 8i32;
        let from_col: i32 = from_i32 % 8i32;
        let to_row: i32 = to_i32 / 8i32;
        let to_col: i32 = to_i32 % 8i32;
        
        // Check for forward move (same column, destination empty)
        let is_one_forward: bool = (to_i32 == from_i32 + direction) && (from_col == to_col) && (dest_piece == 0field);
        
        // Check for two-square first move
        let is_starting_square: bool = is_white 
            ? is_white_pawn_first_move(from)
            : is_black_pawn_first_move(from);
        
        let intermediate_square: i32 = from_i32 + direction;
        let intermediate_arr: u8 = (intermediate_square < 32i32) ? 1u8 : 2u8;
        let intermediate_idx: u32 = get_board_index(intermediate_square as u32);
        let intermediate_piece: field = (intermediate_arr == 1u8) 
            ? get_array_value(board1, intermediate_idx) 
            : get_array_value(board2, intermediate_idx);
        
        let is_two_forward: bool = is_starting_square 
            && (to_i32 == from_i32 + 2i32 * direction) 
            && (from_col == to_col)
            && (dest_piece == 0field)
            && (intermediate_piece == 0field); // Intermediate square must be empty
        
        // Check for diagonal capture (one square diagonally, destination has enemy piece)
        let col_diff: i32 = to_col - from_col;
        let col_diff_abs: i32 = (col_diff < 0i32) ? -col_diff : col_diff;
        let is_diagonal: bool = (to_i32 == from_i32 + direction) && (col_diff_abs == 1i32);
        
        // Check if destination has enemy piece
        let is_enemy: bool = is_white
            ? (dest_piece != 0field && dest_piece < 10field)
            : (dest_piece != 0field && dest_piece >= 10field);
        
        let is_capture: bool = is_diagonal && is_enemy;
        
        // Valid pawn move: forward (1 or 2) OR diagonal capture
        // 
        // MISSING FEATURES (TODO):
        // 1. EN PASSANT: Special capture where pawn captures an enemy pawn that just moved 2 squares
        //    - Requires: tracking last move (which piece moved, from where, to where)
        //    - Complexity: moderate - need game state to track previous move
        //    - Rarity: ~2-5% of games
        // 
        // 2. PROMOTION DETECTION: This function validates the move but doesn't detect promotion
        //    - When pawn reaches rank 8 (white) or rank 1 (black), it must promote
        //    - Current: pawn_move_promotion() exists but must be called separately
        //    - TODO: Return tuple (is_valid, needs_promotion) or add promotion flag to move validation
        //    - Alternatively: Game flow should check if destination is promotion rank after move
        return is_one_forward || is_two_forward || is_capture;
    }

    // KNIGHT
    inline knight_move_or_capture_logic(
        from: u32,
        to: u32,
        board1: [field; 32],
        board2: [field; 32],
        is_white: bool
    ) -> bool {
        // Convert indices to (row, col)
        let from_row: i32 = (from as i32) / 8i32;
        let from_col: i32 = (from as i32) % 8i32;
        let to_row: i32 = (to as i32) / 8i32;
        let to_col: i32 = (to as i32) % 8i32;

        // Calculate row and column differences (absolute value)
        let row_diff: i32 = from_row - to_row;
        let row_diff_abs: i32 = (row_diff < 0i32) ? -row_diff : row_diff;
        let col_diff: i32 = from_col - to_col;
        let col_diff_abs: i32 = (col_diff < 0i32) ? -col_diff : col_diff;

        // Knight moves: (2,1) or (1,2)
        let is_knight_move: bool = (row_diff_abs == 2i32 && col_diff_abs == 1i32) || (row_diff_abs == 1i32 && col_diff_abs == 2i32);

        // Get destination piece
        let to_arr: u8 = (to < 32u32) ? 1u8 : 2u8;
        let to_idx: u32 = get_board_index(to);
        let dest_piece: field = (to_arr == 1u8) ? get_array_value(board1, to_idx) : get_array_value(board2, to_idx);

        // For this example, assume white pieces are >= 10field, black < 10field
        let is_enemy: bool = is_white
            ? (dest_piece != 0field && dest_piece < 10field)
            : (dest_piece != 0field && dest_piece >= 10field);

        // Allow move if destination is empty or has enemy piece
        let is_empty: bool = dest_piece == 0field;

        return is_knight_move && (is_empty || is_enemy);
    }
    
    // ROOK
    inline rook_move_or_capture_logic(
        from: u32,
        to: u32,
        board1: [field; 32],
        board2: [field; 32],
        is_white: bool
    ) -> bool {
        // Convert indices to (row, col)
        let from_row: i32 = (from as i32) / 8i32;
        let from_col: i32 = (from as i32) % 8i32;
        let to_row: i32 = (to as i32) / 8i32;
        let to_col: i32 = (to as i32) % 8i32;

        // Check if move is straight (horizontal or vertical)
        let is_horizontal: bool = from_row == to_row && from_col != to_col;
        let is_vertical: bool = from_col == to_col && from_row != to_row;
        let is_rook_move: bool = is_horizontal || is_vertical;

        // Get destination piece
        let to_arr: u8 = (to < 32u32) ? 1u8 : 2u8;
        let to_idx: u32 = get_board_index(to);
        let dest_piece: field = (to_arr == 1u8) ? get_array_value(board1, to_idx) : get_array_value(board2, to_idx);

        // Check if destination has enemy piece or is empty
        // White pieces: 11-16, Black pieces: 1-6
        let is_enemy: bool = is_white
            ? (dest_piece != 0field && dest_piece < 10field)
            : (dest_piece != 0field && dest_piece >= 10field);
        let is_empty: bool = dest_piece == 0field;

        // Simplified path checking: For now, just check if move pattern is valid
        // Full path checking will be implemented in separate validation function
        // This is a temporary simplification to keep program size manageable

        // Valid rook move: straight line and destination is empty or enemy
        return is_rook_move && (is_empty || is_enemy);
    }

    // BISHOP
    inline bishop_move_or_capture_logic(
        from: u32,
        to: u32,
        board1: [field; 32],
        board2: [field; 32],
        is_white: bool
    ) -> bool {
        // Convert indices to (row, col)
        let from_row: i32 = (from as i32) / 8i32;
        let from_col: i32 = (from as i32) % 8i32;
        let to_row: i32 = (to as i32) / 8i32;
        let to_col: i32 = (to as i32) % 8i32;

        // Calculate row and column differences (absolute value)
        let row_diff: i32 = from_row - to_row;
        let row_diff_abs: i32 = (row_diff < 0i32) ? -row_diff : row_diff;
        let col_diff: i32 = from_col - to_col;
        let col_diff_abs: i32 = (col_diff < 0i32) ? -col_diff : col_diff;

        // Bishop moves diagonally: row_diff_abs must equal col_diff_abs
        let is_diagonal: bool = (row_diff_abs == col_diff_abs) && (row_diff_abs > 0i32);

        // Get destination piece
        let to_arr: u8 = (to < 32u32) ? 1u8 : 2u8;
        let to_idx: u32 = get_board_index(to);
        let dest_piece: field = (to_arr == 1u8) ? get_array_value(board1, to_idx) : get_array_value(board2, to_idx);

        // Check if destination has enemy piece or is empty
        // White pieces: 11-16, Black pieces: 1-6
        let is_enemy: bool = is_white
            ? (dest_piece != 0field && dest_piece < 10field)
            : (dest_piece != 0field && dest_piece >= 10field);
        let is_empty: bool = dest_piece == 0field;

        // Simplified path checking: For now, just check if move pattern is valid
        // Full path checking will be implemented in separate validation function (Task 1.5)
        // This is a temporary simplification to keep program size manageable

        // Valid bishop move: diagonal line and destination is empty or enemy
        return is_diagonal && (is_empty || is_enemy);
    }

    // QUEEN
    inline queen_move_or_capture_logic(
        from: u32,
        to: u32,
        board1: [field; 32],
        board2: [field; 32],
        is_white: bool
    ) -> bool {
        // Queen combines rook and bishop movement
        // Can move in straight lines (like rook) or diagonals (like bishop)
        let rook_valid: bool = rook_move_or_capture_logic(from, to, board1, board2, is_white);
        let bishop_valid: bool = bishop_move_or_capture_logic(from, to, board1, board2, is_white);
        
        return rook_valid || bishop_valid;
    }

    // KING
    // TODO: Castling not implemented - requires checking:
    //   1. King and rook haven't moved yet (requires game state tracking)
    //   2. No pieces between king and rook
    //   3. King not in check, doesn't pass through check, doesn't end in check
    //   4. Complexity: high - needs extensive game state
    inline king_move_logic(from: u32, to: u32) -> bool {
        let from_row: i32 = (from as i32) / 8i32;
        let from_col: i32 = (from as i32) % 8i32;
        let to_row: i32 = (to as i32) / 8i32;
        let to_col: i32 = (to as i32) % 8i32;
        let row_diff: i32 = from_row - to_row;
        let row_diff_abs: i32 = (row_diff < 0i32) ? -row_diff : row_diff;
        let col_diff: i32 = from_col - to_col;
        let col_diff_abs: i32 = (col_diff < 0i32) ? -col_diff : col_diff;
        return (row_diff_abs <= 1i32) && (col_diff_abs <= 1i32) && !(row_diff_abs == 0i32 && col_diff_abs == 0i32);
    }

    inline king_move_or_capture_logic(
        from: u32,
        to: u32,
        board1: [field; 32],
        board2: [field; 32],
        is_white: bool
    ) -> bool {
        // Convert indices to (row, col)
        let from_row: i32 = (from as i32) / 8i32;
        let from_col: i32 = (from as i32) % 8i32;
        let to_row: i32 = (to as i32) / 8i32;
        let to_col: i32 = (to as i32) % 8i32;

        // Calculate row and column differences (absolute value)
        let row_diff: i32 = from_row - to_row;
        let row_diff_abs: i32 = (row_diff < 0i32) ? -row_diff : row_diff;
        let col_diff: i32 = from_col - to_col;
        let col_diff_abs: i32 = (col_diff < 0i32) ? -col_diff : col_diff;

        // King moves: one square in any direction
        let is_king_move: bool = (row_diff_abs <= 1i32) && (col_diff_abs <= 1i32) && !(row_diff_abs == 0i32 && col_diff_abs == 0i32);

        // Get destination piece
        let to_arr: u8 = (to < 32u32) ? 1u8 : 2u8;
        let to_idx: u32 = get_board_index(to);
        let dest_piece: field = (to_arr == 1u8) ? get_array_value(board1, to_idx) : get_array_value(board2, to_idx);

        // For this example, assume white pieces are >= 10field, black < 10field
        let is_enemy: bool = is_white
            ? (dest_piece != 0field && dest_piece < 10field)
            : (dest_piece != 0field && dest_piece >= 10field);

        let is_empty: bool = dest_piece == 0field;

        // Valid king move: one square in any direction, and destination is empty or enemy
        // 
        // MISSING FEATURE (TODO):
        // CASTLING: Special move where king moves 2 squares toward rook, rook jumps over
        //   - Requirements:
        //     * Neither piece has moved before (needs move history tracking)
        //     * No pieces between them
        //     * King not in check, doesn't pass through check, doesn't land in check
        //   - Complexity: high - requires significant game state tracking
        //   - Rarity: ~20-30% of games
        return is_king_move && (is_empty || is_enemy);
    }


    ////////////////////////////////////////////////////////////////////////////////////
    //                                VISIBILITY                                      //
    ////////////////////////////////////////////////////////////////////////////////////

    // PLACEHOLDER: for board visibility rules


    ////////////////////////////////////////////////////////////////////////////////////
    //                               GAME FUNCTIONS                                   //
    ////////////////////////////////////////////////////////////////////////////////////

    // TODO: rudimentary checkmate (must take the king), update/improve this function
    function is_checkmate(board1: [field; 32], board2: [field; 32]) -> u8 {
        let white_king_present: bool = contains_piece(board1, 16field) || contains_piece(board2, 16field);
        let black_king_present: bool = contains_piece(board1, 6field) || contains_piece(board2, 6field);

        return (!black_king_present)
            ? 1u8
            : ((!white_king_present) ? 2u8 : 0u8);
    }

    function main(dummy: u8) -> field {
        let board1: [field; 32] = [
            // squares 0..31
            2field, 3field, 4field, 5field, 6field, 4field, 3field, 2field,
            1field, 1field, 1field, 1field, 1field, 1field, 1field, 1field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field
        ];
        let board2: [field; 32] = [
            // squares 32..63
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            11field, 11field, 11field, 11field, 11field, 11field, 11field, 11field,
            12field, 13field, 14field, 15field, 16field, 14field, 13field, 12field
        ];

        // Example: get value at square 0 (board1[0]), square 40 (board2[8]), etc.
        let value: field = board1[3u32]; // White Queen at d1

        return value;
    }
    // Python takes the game record and does game play
    //      in charge of validating moves & board visibility
    //      sends signal that then triggers finish_game function
    //      finish_game updates the mapping of each player's rank


    ////////////////////////////////////////////////////////////////////////////////////
    //                                 RANKINGS                                       //
    ////////////////////////////////////////////////////////////////////////////////////

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


    ////////////////////////////////////////////////////////////////////////////////////
    //                                    TESTS                                       //
    ////////////////////////////////////////////////////////////////////////////////////
    // To make sure everything works //
    transition test_move_piece(dummy: u8) {
        // Initial board setup
        let board1: [field; 32] = [
            2field, 3field, 4field, 5field, 6field, 4field, 3field, 2field,
            1field, 1field, 1field, 1field, 1field, 1field, 1field, 1field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field
        ];
        let board2: [field; 32] = [
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            11field, 11field, 11field, 11field, 11field, 11field, 11field, 11field,
            12field, 13field, 14field, 15field, 16field, 14field, 13field, 12field
        ];

        // Move the piece at index 1 (white knight) to index 10 (empty square)
        let (new_board1, new_board2) = move_piece(board1, board2, 1u32, 10u32);

        // Assert the move happened
        assert_eq(new_board1[1u32], 0field);    // Source should be empty
        assert_eq(new_board1[10u32], 3field);   // Destination should have the knight
    }

    // Black wins by taking White's King - must take the king
    // To test run: leo run test_fools_mate 0u8 
    // Note: '0u8' is a dummy parameter, transition functions must have at least one param in leo
    // TEMPORARILY COMMENTED OUT TO REDUCE PROGRAM SIZE DURING DEVELOPMENT
    /* 
    transition test_fools_mate(dummy: u8) {
        // Initial board setup
        let board1: [field; 32] = [
            // 0..7: Black major pieces (a8-h8)
            2field, 3field, 4field, 5field, 6field, 4field, 3field, 2field,
            // 8..15: Black pawns (a7-h7)
            1field, 1field, 1field, 1field, 1field, 1field, 1field, 1field,
            // 16..31: Empty
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field
        ];
        let board2: [field; 32] = [
            // 32..39: Empty
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            // 40..47: Empty
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            // 48..55: White pawns (a2-h2)
            11field, 11field, 11field, 11field, 11field, 11field, 11field, 11field,
            // 56..63: White major pieces (a1-h1)
            12field, 13field, 14field, 15field, 16field, 14field, 13field, 12field
        ];

        // 1. White: f2 (53) to f3 (45)
        let (board1a, board2a) = move_piece(board1, board2, 53u32, 45u32);

        // 1. Black: e7 (12) to e6 (20)
        let (board1b, board2b) = move_piece(board1a, board2a, 12u32, 20u32);

        // 2. White: g2 (54) to g4 (38)
        let (board1c, board2c) = move_piece(board1b, board2b, 54u32, 38u32);

        // 2. Black: Qd8 (3) to h4 (39)
        let (board1d, board2d) = move_piece(board1c, board2c, 3u32, 39u32);

        // 3. Black: Qh4 (39) to e1 (60) -- captures white king
        let (board1e, board2e) = move_piece(board1d, board2d, 39u32, 60u32);

        // 1. Assert the white king is no longer present in either array
        assert(contains_piece(board1e, 16field) == false); // White king not in board1
        assert(contains_piece(board2e, 16field) == false); // White king not in board2

        // 2. Assert the black queen is now on e1 (square 60, which is board2[28])
        assert(get_array_value(board2e, get_board_index(60u32)) == 5field);

        // 3. Assert the white king is not on e1 (should be replaced by queen)
        assert(get_array_value(board2e, get_board_index(60u32)) != 16field);

        // 4. Assert the checkmate function returns the correct result
        let result: u8 = is_checkmate(board1e, board2e);
        assert_eq(result, 2u8); // Black wins by checkmate
        assert(result == 2u8);  // "Checkmate"

        // Print out the value at board2[28u32] (e1) after the final move
        let e1_value: field = get_array_value(board2e, get_board_index(60u32));
        assert(e1_value == 5field); // Should be queen
        assert(e1_value != 16field); // Should not be king

        // Check if the king is still present anywhere
        assert(contains_piece(board1e, 16field) == false);
        assert(contains_piece(board2e, 16field) == false);
    }
    */
    
    // pawn
    // Output 1u8 means the test passed.
    transition test_pawn_two_squares(dummy: u8) -> u8 {
        // White pawn at f2 (53), moving to f4 (37) on first move
        let board1: [field; 32] = [
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field
        ];
        let can_advance: bool = pawn_move_advance(board1, 53i32, 37i32, -8i32, true);
        return can_advance ? 1u8 : 0u8;
    }

    // Output 1u8 means the test passed.
    transition test_pawn_one_square(dummy: u8) -> u8 {
        // White pawn at f4 (37), trying to move to f6 (21) (should NOT be allowed)
        let board1: [field; 32] = [
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field
        ];
        let can_advance_two: bool = pawn_move_advance(board1, 37i32, 21i32, -8i32, true); // Should be false
        let can_advance_one: bool = pawn_move_advance(board1, 37i32, 29i32, -8i32, true); // Should be true
        // Return 1u8 if only the one-square move is allowed
        return (!can_advance_two && can_advance_one) ? 1u8 : 0u8;
    }

    // test king movement logic, returns 1u8 if check passes
    transition test_king_move_only(dummy: u8) -> u8 {
        let move_empty: bool = king_move_logic(60u32, 61u32);
        let move_invalid: bool = king_move_logic(60u32, 62u32);
        let move_no_move: bool = king_move_logic(60u32, 60u32);
        return (move_empty && !move_invalid && !move_no_move) ? 1u8 : 0u8;
    }
    // off-chain test: can use output from get_square_value to check in another programming language

    // ran into issues when writing test for pawn promotion

    // rook
    // Test rook movement validation  
    // Output 1u8 means the test passed
    // NOTE: This tests basic move pattern validation only (straight lines)
    // Path obstacle checking will be added in Task 1.5
    transition test_rook_moves(dummy: u8) -> u8 {
        // Setup board with a white rook at a1 (56)
        let board1: [field; 32] = [
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field
        ];
        let board2: [field; 32] = [
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            12field, 0field, 0field, 0field, 0field, 0field, 0field, 0field  // White rook at a1
        ];

        // Test 1: Valid vertical move (a1 to a4) - should be true
        let valid_vertical: bool = rook_move_or_capture_logic(56u32, 32u32, board1, board2, true);

        // Test 2: Valid horizontal move (a1 to d1) - should be true
        let valid_horizontal: bool = rook_move_or_capture_logic(56u32, 59u32, board1, board2, true);

        // Test 3: Invalid diagonal move (a1 to b2) - should be false
        let invalid_diagonal: bool = rook_move_or_capture_logic(56u32, 49u32, board1, board2, true);

        // Test 4: Invalid move to friendly piece (a1 to b1 with friendly piece)
        let board2_friendly: [field; 32] = [
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            12field, 11field, 0field, 0field, 0field, 0field, 0field, 0field  // White rook at a1, pawn at b1
        ];
        let invalid_friendly: bool = rook_move_or_capture_logic(56u32, 57u32, board1, board2_friendly, true);

        // Test 5: Test capture of enemy piece
        let board2_capture: [field; 32] = [
            1field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,  // Black pawn at a8 (0)
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            12field, 0field, 0field, 0field, 0field, 0field, 0field, 0field  // White rook at a1 (56)
        ];
        // Valid capture move - should be true
        let valid_capture: bool = rook_move_or_capture_logic(56u32, 0u32, board1, board2_capture, true);

        // Return 1u8 if all tests pass
        return (valid_vertical && valid_horizontal && !invalid_diagonal && !invalid_friendly && valid_capture) ? 1u8 : 0u8;
    }

    // bishop
    // Test bishop movement validation
    // Output true means the test passed
    // NOTE: This tests basic move pattern validation only (diagonal lines)
    // Path obstacle checking will be added in Task 1.5
    // TEMPORARILY COMMENTED OUT TO REDUCE PROGRAM SIZE - will re-enable after program split
    /*
    function test_bishop_moves(dummy: u8) -> bool {
        // Setup board with a white bishop at c1 (58)
        let board1: [field; 32] = [
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field
        ];
        let board2: [field; 32] = [
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 14field, 0field, 0field, 0field, 0field, 0field  // White bishop at c1 (58)
        ];

        // Test 1: Valid diagonal move (c1 to f4) - should be true
        let valid_diagonal_ne: bool = bishop_move_or_capture_logic(58u32, 37u32, board1, board2, true);

        // Test 2: Valid diagonal move (c1 to a3) - should be true
        let valid_diagonal_nw: bool = bishop_move_or_capture_logic(58u32, 40u32, board1, board2, true);

        // Test 3: Invalid horizontal move (c1 to f1) - should be false
        let invalid_horizontal: bool = bishop_move_or_capture_logic(58u32, 61u32, board1, board2, true);

        // Test 4: Invalid vertical move (c1 to c4) - should be false
        let invalid_vertical: bool = bishop_move_or_capture_logic(58u32, 34u32, board1, board2, true);

        // Test 5: Invalid move to friendly piece (c1 to d2 with friendly piece)
        let board2_friendly: [field; 32] = [
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 14field, 0field, 0field, 0field, 0field, 0field  // White bishop at c1 (58)
        ];
        let board1_friendly: [field; 32] = [
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 11field, 0field, 0field, 0field, 0field  // White pawn at d4 (27)
        ];
        let invalid_friendly: bool = bishop_move_or_capture_logic(58u32, 49u32, board1_friendly, board2_friendly, true);

        // Test 6: Test capture of enemy piece
        let board1_capture: [field; 32] = [
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 1field, 0field, 0field, 0field, 0field, 0field, 0field,  // Black pawn at b6 (17)
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field
        ];
        let board2_capture: [field; 32] = [
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 0field, 0field, 0field, 0field, 0field, 0field,
            0field, 0field, 14field, 0field, 0field, 0field, 0field, 0field  // White bishop at c1 (58)
        ];
        // Valid capture move - should be true
        let valid_capture: bool = bishop_move_or_capture_logic(58u32, 17u32, board1_capture, board2_capture, true);

        // Return true if all tests pass
        return (valid_diagonal_ne && valid_diagonal_nw && !invalid_horizontal && !invalid_vertical && !invalid_friendly && valid_capture);
    }
    */

    // knight  
    // TODO: need test for knight movement & knight capture

    ///////////////////////////
    //  ULTIMATE TO DO LIST  //
    ///////////////////////////
    
    // 1. reduce logic in pawn_move_advance
    // 2. get test_pawn_capture working
    // 3. get test_pawn_two_square_first_move working
    // 4. code rules for knights
    // 5. code rules for rooks
    // 6. code rules for bishops
    // 7. code rules for queens
    // 8. code rules for kings
    // 9. tackle visibility rules
    // 10. calculate ELO rank
    // 11. connect the pieces

}
