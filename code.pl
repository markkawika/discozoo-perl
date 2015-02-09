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

for my $i (0 .. $#ARGV) {
  push @animals, $animal{$ARGV[$i]};
}

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

my @boards_left = @board_list;

printf "There are %d total boards to eliminate.\n", scalar(@boards_left);

my $pick = Board->new();
my $num_picks = 1;
my @picks = ();
push @picks, $pick;

while (@boards_left > 0) { 
  my $max_eliminated = 0;
  my $max_x = -1;
  my $max_y = -1;
  for my $y (0 .. 4) {
    for my $x (0 .. 4) {
      my $num_eliminated = 0;
      for my $board (@boards_left) {
        my $spot = $board->getBoardPos($x, $y);
        if ($spot =~ /\d/) {
          $num_eliminated++;
        }
      }
      if ($num_eliminated > $max_eliminated) {
        $max_eliminated = $num_eliminated;
        $max_x = $x;
        $max_y = $y;
      }
    }
  }

  # We have found the best choice.
  my @boards_temp = ();
  for my $board (@boards_left) {
    my $spot = $board->getBoardPos($max_x, $max_y);
    if ($spot eq ' ') {
      $board->setBoardPos($max_x, $max_y, 'X');
      push @boards_temp, $board;
    }
  }
  @boards_left = @boards_temp;
  printf "After $num_picks picks, %d boards remaining.\n", scalar(@boards_left);

  # Print out the picks:
  my $last_pick = $picks[-1];
  my $this_pick = $last_pick->clone();
  $this_pick->setBoardPos($max_x, $max_y, 'X');
  print "Pick $num_picks:\n\n";
  $this_pick->printBoard();
  push @picks, $this_pick;
  $num_picks++;
}
