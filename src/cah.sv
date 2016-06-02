//*************************************************************************************************
//        File: cah.sv
//      Author: Scott Lawson
//     Project: Cards Against Humanity Hand Generator
// Description: Randomly generates sequences of hands from two Cards Against Humanity (C) expansion
//              packs and the main game. The two decks used here do not represent any real
//              separation of the cards in the games. They're only used to demonstrate a random
//              sequence.
//*************************************************************************************************

// forward declaration of Deck class defined after module definition
typedef class Deck;

module CAH;

`define NUM_ROUNDS 5
`define NUM_WHITE_CARDS_PER_HAND 4

// I know what you're thinking, and I agree - there are better ways to do this.
`define D1B_PATH "cards/deck1black.txt"
`define D1W_PATH "cards/deck1white.txt"
`define D2B_PATH "cards/deck2black.txt"
`define D2W_PATH "cards/deck2white.txt"

Deck deck1;
Deck deck2;

initial
begin

    deck1 = new(`D1B_PATH, `D1W_PATH);
    deck2 = new(`D2B_PATH, `D2W_PATH);

    for (int i=0; i<`NUM_ROUNDS; ++i)
        randsequence (round)
            round       : black white newHand;
            black       : deck1Black | deck2Black;
            white       : deck1White | deck2White;
            deck1Black  : { deck1.playBlack(); };
            deck2Black  : { deck2.playBlack(); };
            deck1White  : { deck1.playWhite(); };
            deck2White  : { deck2.playWhite(); };
            newHand     : { $display("\n");    };
        endsequence

    $finish;

end

endmodule

class Deck;

    string blackCards[$];
    string whiteCards[$];

    extern function new(string blackDeckPath, string whiteDeckPath);
    extern function void playBlack;
    extern function void playWhite;

endclass

function Deck::new(string blackDeckPath, string whiteDeckPath);

    integer fid;
    string line;

    fid = $fopen(blackDeckPath, "r");
    if (fid == 0)
        $fatal("Cannot open black deck at path: %s", blackDeckPath);

    while (!$feof(fid))
        if ($fgets(line, fid))
            blackCards.push_front(line);

    fid = $fopen(whiteDeckPath, "r");
    if (fid == 0)
        $fatal("Cannot open white deck at path: %s", whiteDeckPath);

    while (!$feof(fid))
        if ($fgets(line, fid))
            whiteCards.push_front(line);

    blackCards.shuffle();
    whiteCards.shuffle();

endfunction

function void Deck::playBlack;

    string card = blackCards.pop_front();

    $display("%s ", card);
    blackCards.push_back(card);

endfunction

function void Deck::playWhite;

    string card;
    string addBack[$];

    for (int i=0; i < `NUM_WHITE_CARDS_PER_HAND; ++i)
    begin
        card = whiteCards.pop_front();
        $display("\t%s ", card);
        addBack.push_back(card);
    end

    while ($size(addBack, 0) > 0)
        whiteCards.push_back(addBack.pop_front);

    whiteCards.shuffle();

endfunction

