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

my @test_animals = (
  Pig->new(),
  Sheep->new(),
  Horse->new(),
  Rabbit->new(),
  Cow->new(),
  Unicorn->new(),
  Kangaroo->new(),
  Platypus->new(),
  Crocodile->new(),
  Koala->new(),
  Cockatoo->new(),
  Tiddalik->new(),
  Zebra->new(),
  Hippo->new(),
  Giraffe->new(),
  Lion->new(),
  Elephant->new(),
  Gryphon->new(),
  Bear->new(),
  Skunk->new(),
  Beaver->new(),
  Moosey->new(),
  Fox->new(),
  Sasquatch->new(),
);

my @boards = ();
my $board = Board->new();
my $animal1 = Kangaroo->new();
my $animal2 = Koala->new();
$board->insertAnimal($animal1, 0, 0);
if ($board->willAnimalFit($animal2, 1, 1)) {
  print "OMG it will fit\n";
}
$board->insertAnimal($animal2, 1, 1);
$board->printBoard();
