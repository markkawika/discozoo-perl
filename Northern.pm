#!/usr/bin/perl

package Northern;

use Animal;

my $bear_shape = [
  q{XX},
  q{ X},
  q{ X},
];

my $skunk_shape = [
  q{ XX},
  q{XX },
];

my $beaver_shape = [
  q{  X},
  q{XX },
  q{  X},
];

my $moose_shape = [
  q{X X},
  q{ X },
];

my $fox_shape = [
  q{XX },
  q{  X},
];

my $sasquatch_shape = [
  q{X},
  q{X},
];

our $bear      = Animal->new('bear',      $bear_shape);
our $skunk     = Animal->new('skunk',     $skunk_shape);
our $beaver    = Animal->new('beaver',    $beaver_shape);
our $moose     = Animal->new('moose',     $moose_shape);
our $fox       = Animal->new('fox',       $fox_shape);
our $sasquatch = Animal->new('sasquatch', $sasquatch_shape);

our @animals = (
  [ 'bear',      $bear      ],
  [ 'skunk',     $skunk     ],
  [ 'beaver',    $beaver    ],
  [ 'moose',     $moose     ],
  [ 'fox',       $fox       ],
  [ 'sasquatch', $sasquatch ],
);

1;
