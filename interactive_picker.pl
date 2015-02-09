#!/usr/bin/perl

use strict;
use warnings;
use English qw( -no_match_vars );
use Carp;

use Farm;
use Outback;
use Savanna;
use Northern;
use Board;

my $pig = Pig->new();
my $sheep = Sheep->new();
my $horse = Horse->new();
my $rabbit = Rabbit->new();
my $cow = Cow->new();
my $unicorn = Unicorn->new();
my $kangaroo = Kangaroo->new();
my $platypus = Platypus->new();
my $crocodile = Crocodile->new();
my $koala = Koala->new();
my $cockatoo = Cockatoo->new();
my $tiddalik = Tiddalik->new();
my $zebra = Zebra->new();
my $hippo = Hippo->new();
my $giraffe = Giraffe->new();
my $lion = Lion->new();
my $elephant = Elephant->new();
my $gryphon = Gryphon->new();
my $bear = Bear->new();
my $skunk = Skunk->new();
my $beaver = Beaver->new();
my $moosey = Moosey->new();
my $fox = Fox->new();
my $sasquatch = Sasquatch->new();

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

printf "There are %d total boards to eliminate.\n", scalar(@boards_left);

while (@boards_left > 0) { 
  my $max_found = 0;
  my $max_x = -1;
  my $max_y = -1;
  for my $y (0 .. 4) {
    for my $x (0 .. 4) {
      my $num_found = 0;
      for my $board (@boards_left) {
        my $animal_at_pos = $board->getNameAtPos($x, $y);
        if ($animal_at_pos eq $wanted_animal) {
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

  my @boards_temp = ();
  for my $board (@boards_left) {
    my $spot = $board->getBoardPos($max_x, $max_y);
    if ($spot eq $result) {
      push @boards_temp, $board;
    }
  }
  @boards_left = @boards_temp;
  printf "\nThere are now %d boards remaining.\n", scalar(@boards_left);
}
