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

my $penguin    = $Polar::penguin;
my $seal       = $Polar::seal;
my $muskox     = $Polar::muskox;
my $polar_bear = $Polar::polar_bear;
my $walrus     = $Polar::walrus;
my $yeti       = $Polar::yeti;

my %animal = (
  pig        => $pig,
  sheep      => $sheep,
  horse      => $horse,
  rabbit     => $rabbit,
  cow        => $cow,
  unicorn    => $unicorn,
  kangaroo   => $kangaroo,
  platypus   => $platypus,
  crocodile  => $crocodile,
  koala      => $koala,
  cockatoo   => $cockatoo,
  tiddalik   => $tiddalik,
  zebra      => $zebra,
  hippo      => $hippo,
  giraffe    => $giraffe,
  lion       => $lion,
  elephant   => $elephant,
  gryphon    => $gryphon,
  bear       => $bear,
  skunk      => $skunk,
  beaver     => $beaver,
  moosey     => $moosey,
  fox        => $fox,
  sasquatch  => $sasquatch,
  penguin    => $penguin,
  seal       => $seal,
  muskox     => $muskox,
  polar_bear => $polar_bear,
  walrus     => $walrus,
  yeti       => $yeti,
);


my $empty_board = Board->new();
my @animals = ();

# The animal you list first is the one we will try to find first.
my $wanted_animal = $ARGV[0];

my $current_board = Board->new();
my $num_animals = 0; # For statistics
my $id_string = q{};

for my $i (0 .. $#ARGV) {
  my $animal_name = $ARGV[$i];
  if (exists $animal{$animal_name}) {
    push @animals, $animal{$animal_name};
    $num_animals = $current_board->addOccupant($animal_name);
    $id_string .= $num_animals;
  }
  else {
    croak "Invalid animal name: [$animal_name]";
  }
}


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
        if ($animal_at_pos eq $wanted_animal) {
          # 10 instead of 1 is a hack to prioritize an animal.
          $cur_score += 10;
        }
        elsif ($animal_at_pos ne 'empty') {
          $cur_score++;
        }
      }
      if ($cur_score > $max_score) {
        $max_score = $cur_score;
        $max_x = $x;
        $max_y = $y;
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

  # Calculate statistics about what might be there
  my $wanted_count = 0;
  my $animal_count = 0;
  my $empty_count = 0;
  for my $board (@boards_left) {
    my $name = $board->getNameAtPos($max_x, $max_y);
    if ($name eq $wanted_animal) {
      $wanted_count++;
    }
    elsif ($name ne 'empty') {
      $animal_count++;
    }
    else {
      $empty_count++;
    }
  }
  print "\n";
  printf "Chance for wanted: %.1f%%\n", 100.0 * ($wanted_count / @boards_left);
  printf "Chance for animal: %.1f%%\n", 100.0 * ($animal_count / @boards_left);
  printf "Chance for empty:  %.1f%%\n", 100.0 * ($empty_count / @boards_left);

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
