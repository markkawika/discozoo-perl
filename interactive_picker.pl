#!/usr/bin/perl

use strict;
use warnings;
use English qw( -no_match_vars );
use Carp;
use Data::Dumper;

use Board;
use Farm;
use Outback;
use Savanna;
use Northern;

my $pig     = $Farm::pig;
my $sheep   = $Farm::sheep;
my $horse   = $Farm::horse;
my $rabbit  = $Farm::rabbit;
my $cow     = $Farm::cow;
my $unicorn = $Farm::unicorn;

my $kangaroo  = $Outback::kangaroo;
my $platypus  = $Outback::platypus;
my $crocodile = $Outback::crocodile;
my $koala     = $Outback::koala;
my $cockatoo  = $Outback::cockatoo;
my $tiddalik  = $Outback::tiddalik;

my $zebra    = $Savanna::zebra;
my $hippo    = $Savanna::hippo;
my $giraffe  = $Savanna::giraffe;
my $lion     = $Savanna::lion;
my $elephant = $Savanna::elephant;
my $gryphon  = $Savanna::gryphon;

my $bear      = $Northern::bear;
my $skunk     = $Northern::skunk;
my $beaver    = $Northern::beaver;
my $moosey    = $Northern::moosey;
my $fox       = $Northern::fox;
my $sasquatch = $Northern::sasquatch;

my %animal = (
  pig       => $pig,
  sheep     => $sheep,
  horse     => $horse,
  rabbit    => $rabbit,
  cow       => $cow,
  unicorn   => $unicorn,
  kangaroo  => $kangaroo,
  platypus  => $platypus,
  crocodile => $crocodile,
  koala     => $koala,
  cockatoo  => $cockatoo,
  tiddalik  => $tiddalik,
  zebra     => $zebra,
  hippo     => $hippo,
  giraffe   => $giraffe,
  lion      => $lion,
  elephant  => $elephant,
  gryphon   => $gryphon,
  bear      => $bear,
  skunk     => $skunk,
  beaver    => $beaver,
  moosey    => $moosey,
  fox       => $fox,
  sasquatch => $sasquatch,
);


my @a1_boards = ();
my $empty_board = Board->new();
my @animals = ();

# The animal you list first is the one we will try to find first.
my $wanted_animal = $ARGV[0];

my $current_board = Board->new();
my $num_animals = 0;

for my $i (0 .. $#ARGV) {
  my $animal_name = $ARGV[$i];
  if (exists $animal{$animal_name}) {
    push @animals, $animal{$animal_name};
    $num_animals = $current_board->addOccupant($animal_name);
  }
  else {
    croak "Invalid animal name: [$animal_name]";
  }
}


# Initialize the loop with the empty state:
my @board_list = ( $empty_board );

for my $animal (@animals) {
  my @new_board_list = ();
  for my $board (@board_list) {
    for my $y (0 .. 4) {
      for my $x (0 .. 4) {
        if ($board->willAnimalFit($animal, $x, $y)) {
          my $new_board = $board->clone();
          $new_board->insertAnimal($animal, $x, $y);
          push @new_board_list, $new_board;
        }
      }
    }
  }
  @board_list = @new_board_list;
}

# At this point, @board_list contains a list of every single possible board
# configuration at the start of the game.

# Now, find a winning search strategy. My intuition is to always pick a square
# that will maximize the information returned on a miss. In other words,
# reveal a square that, if empty, removes the max number of possibilities.
# The easiest way to show this idea is with pigs. If I reveal (1,1), I
# eliminate four possible pig positions:
#
# PP... .PP.. ..... .....
# PP... .PP.. PP... .PP..
# ..... ..... PP... .PP..
# ..... ..... ..... .....
# ..... ..... ..... .....
#
# This is a better choice than (0,0), which will only eliminate one.
# If you run this strategy on all possible boards will all possible
# combinations of N animals, you find the winning search strategy for those
# two animals.
#
# Another way to think of this is to pick a square with the highest possible
# chance of containing the animal you want.

my @boards_left = @board_list;
my $num_guesses = 0;
my $keep_going;

printf "There are %d total boards to eliminate.\n", scalar(@boards_left);

while (@boards_left > 0) { 
  $num_guesses++;
  my $max_found = 0;
  my $max_x = -1;
  my $max_y = -1;
  for my $y (0 .. 4) {
    for my $x (0 .. 4) {
      next if $current_board->getBoardPos($x, $y) ne q{ };
      my $num_found = 0;
      for my $board (@boards_left) {
        my $animal_at_pos = $board->getNameAtPos($x, $y);
        $animal_at_pos =~ tr/A-Z/a-z/;
        if ($animal_at_pos eq $wanted_animal) {
          $num_found += 10;
        }
        elsif ($animal_at_pos ne 'empty') {
          $num_found++;
        }
      }
      if ($num_found > $max_found) {
        $max_found = $num_found;
        $max_x = $x;
        $max_y = $y;
      }
    }
  }

  if ($max_x == -1) {
    printf "No more board positions to explore.\n";
    exit 0;
  }

  $current_board->setBoardPos($max_x, $max_y, 'X'); 
  $current_board->printBoard();
  my $result = q{};
  while ($result !~ /^[ \d]/) {
    printf "\nResult: [ ";
    for (my $i = 0; $i < $num_animals; $i++) {
      printf $i+1;
    }
    printf "]: ";
    $result = <STDIN>;
    chomp $result;
  }
  
  if ($result ne q{ }) {
    $current_board->setBoardPos($max_x, $max_y, $result);
  }
  else {
    $current_board->setBoardPos($max_x, $max_y, q{-});
  }

  my @boards_temp = ();
  for my $board (@boards_left) {
    my $spot = $board->getBoardPos($max_x, $max_y);
    if ($spot eq $result) {
      push @boards_temp, $board;
    }
  }
  @boards_left = @boards_temp;
  printf "\nThere are now %d boards remaining.\n", scalar(@boards_left);

  if ($num_guesses == 10) {
    printf "Out of guesses. Continue? [y/N] ";
    my $reply = <STDIN>;
    if ($reply !~ /^y/i) {
      exit 0;
    }
  }
}
