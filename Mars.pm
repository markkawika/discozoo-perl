#!/usr/bin/perl

package Mars;

use Animal;

my $rock_shape = [
  q{XX},
  q{XX},
];

my $marsmot_shape = [
  q{ X},
  q{ X},
  q{XX},
];

my $marsmoset_shape = [
  q{X X},
  q{  X},
  q{ X },
];

my $rover_shape = [
  q{ X },
  q{X X},
];

my $martian_shape = [
  q{X X},
  q{ X },
];

my $marsmallow_shape = [
  q{X},
  q{ },
  q{X},
];

our $rock     = Animal->new('rock',     $rock_shape);
our $marsmot  = Animal->new('marsmot',  $marsmot_shape);
our $marsmoset   = Animal->new('marsmoset',   $marsmoset_shape);
our $rover     = Animal->new('rover',     $rover_shape);
our $martian   = Animal->new('martian',   $martian_shape);
our $marsmallow = Animal->new('marsmallow', $marsmallow_shape);

our @animals = (
  [ 'rock',     $rock     ],
  [ 'marsmot',  $marsmot  ],
  [ 'marsmoset',   $marsmoset   ],
  [ 'rover',     $rover     ],
  [ 'martian',   $martian   ],
  [ 'marsmallow', $marsmallow ],
);

1;
