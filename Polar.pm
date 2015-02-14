#!/usr/bin/perl

package Polar;

use Animal;

my $penguin_shape = [
  q{ X },
  q{ X },
  q{X X},
];

my $seal_shape = [
  q{X   },
  q{ X X},
  q{  X },
];

my $muskox_shape = [
  q{XX },
  q{X X},
];

my $polar_bear_shape = [
  q{X X},
  q{  X},
];

my $walrus_shape = [
  q{X  },
  q{ XX},
];

my $yeti_shape = [
  q{X},
  q{ },
  q{X},
];

our $penguin    = Animal->new('penguin',    $penguin_shape);
our $seal       = Animal->new('seal',       $seal_shape);
our $muskox     = Animal->new('muskox',     $muskox_shape);
our $polar_bear = Animal->new('polar_bear', $polar_bear_shape);
our $walrus     = Animal->new('walrus',     $walrus_shape);
our $yeti       = Animal->new('yeti',       $yeti_shape);

our @animals = (
  [ 'penguin',    $penguin    ],
  [ 'seal',       $seal       ],
  [ 'muskox',     $muskox     ],
  [ 'polar_bear', $polar_bear ],
  [ 'walrus',     $walrus     ],
  [ 'yeti',       $yeti       ],
);

1;
