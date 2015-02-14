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
use Polar;
use Jungle;
use Jurassic;
use Ice_Age;
use City;
use Mountain;
use Moon;
use Mars;

my @animal_list = ();

push @animal_list, @Farm::animals;
push @animal_list, @Outback::animals;
push @animal_list, @Savanna::animals;
push @animal_list, @Northern::animals;
push @animal_list, @Polar::animals;
push @animal_list, @Jungle::animals;
push @animal_list, @Jurassic::animals;
push @animal_list, @Ice_Age::animals;
push @animal_list, @City::animals;
push @animal_list, @Mountain::animals;
push @animal_list, @Moon::animals;
push @animal_list, @Mars::animals;

my %animal = ();

for my $animal_data (@animal_list) {
  $animal{$animal_data->[0]} = $animal_data->[1];
}

croak 'No animals listed!' if @ARGV == 0;

my $empty_board = Board->new();
my @animals = ();

# The animal you list first is the one we will try to find first.
my $wanted_animal = $ARGV[0];

my $current_board = Board->new();
my $num_animals = 0; # For statistics
my $id_string = q{};
my %animal_score = ();
$animal_score{empty} = 0;
my %animal_count = ();
$animal_count{empty} = 0;
my $max_name_len = 0;

for my $i (0 .. $#ARGV) {
  my $animal_name = $ARGV[$i];
  my $name_len = length $animal_name;
  $max_name_len = ($name_len > $max_name_len) ? $name_len : $max_name_len;
  if (exists $animal{$animal_name}) {
    push @animals, $animal{$animal_name};
    $num_animals = $current_board->addOccupant($animal_name);
    $id_string .= $num_animals;
    for my $animal_key (keys %animal_score) {
      $animal_score{$animal_key} *= 10;
    }
    $animal_score{$animal_name} = 1;
    $animal_count{$animal_name} = 0;
  }
  else {
    croak "Invalid animal name: [$animal_name]";
  }
}

$max_name_len++; # make room for the colon


# Initialize the loop with the empty state:
my @boards_left = ( $empty_board );

for my $animal (@animals) {
  my @new_boards = ();
  for my $board (@boards_left) {
    for my $y (0 .. 4) {
      for my $x (0 .. 4) {
        if ($board->willAnimalFit($animal, $x, $y)) {
          my $new_board = $board->clone();
          $new_board->insertAnimal($animal, $x, $y);
          push @new_boards, $new_board;
        }
      }
    }
  }
  @boards_left = @new_boards;
}

# At this point, @boards_left contains a list of every single possible board
# configuration at the start of the game.

# My search strategy: pick a square with the highest possible chance of
# containing the animal you want.

my $num_guesses = 0;

printf "There are %d total boards to eliminate.\n", scalar(@boards_left);

while (@boards_left > 0) { 
  $num_guesses++;
  my $max_score = 0;

  # First, identify which spot on the board has the highest chance of
  # containing either the animal we want, or barring that (if we've already
  # found the animal we want, for example), any animal.
  my $max_x = -1;
  my $max_y = -1;
  for my $y (0 .. 4) {
    for my $x (0 .. 4) {
      next if $current_board->getBoardPos($x, $y) ne q{ };
      my $cur_score = 0;
      for my $board (@boards_left) {
        my $animal_at_pos = $board->getNameAtPos($x, $y);
        if (exists $animal_score{$animal_at_pos}) {
          $cur_score += $animal_score{$animal_at_pos};
        }
      }
      if ($cur_score > $max_score) {
        $max_score = $cur_score;
        $max_x = $x;
        $max_y = $y;
      }
      elsif ($cur_score == $max_score && $cur_score > 0) {
        # Switch coordinates half of the time we find a matching score. This
        # will have the effect of making the animal discovery a little more
        # random-appearing, without actually affecting the outcome.
        if (rand >= 0.2) {
          $max_x = $x;
          $max_y = $y;
        }
      }
    }
  }

  if ($max_x == -1) {
    printf "\nYou've found every animal. Congratulations! Final board:\n\n";
    $current_board->printBoard();
    print "\n";
    exit 0;
  }

  # 'X' marks the spot we want the user to reveal.
  $current_board->setBoardPos($max_x, $max_y, 'X'); 
  $current_board->printBoard();

  # Calculate statistics about all possibilities.
  for my $animal_name (keys %animal_count) {
    $animal_count{$animal_name} = 0;
  }
  for my $board (@boards_left) {
    my $name_at_pos = $board->getNameAtPos($max_x, $max_y);
    if (exists $animal_count{$name_at_pos}) {
      $animal_count{$name_at_pos}++;
    }
    else {
      croak 'Name at pos [$name_at_pos] not found in animal_count';
    }
  }

  print "\n";
  for my $animal_name (
    reverse
      sort
        { $animal_score{$a} <=> $animal_score{$b} }
        keys %animal_count
  ) {
    printf "Chance for %-${max_name_len}s %.1f%%\n",
      "${animal_name}:",
      (100.0 * $animal_count{$animal_name}) / @boards_left;
  }

  my $result = q{};
  while ($result !~ /^[ \d]$/) {
    printf "\nResult: [ ${id_string}]: ";
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
  if (scalar @boards_left == 1) {
    print "\nThere is now 1 board remaining.\n";
  }
  else {
    printf "\nThere are now %d boards remaining.\n", scalar(@boards_left);
  }

  if ($num_guesses == 10) {
    printf "\nOut of guesses. Continue? [y/N] ";
    my $reply = <STDIN>;
    chomp $reply;
    if ($reply !~ /^y/i) {
      print "\nFinal board:\n\n";
      $current_board->printBoard();
      print "\n";
      exit 0;
    }
  }
}
