#!/usr/bin/perl

package Farm;

use Animal;

my $sheep_shape = [
  q{XXXX},
];

my $pig_shape = [
  q{XX},
  q{XX},
];

my $rabbit_shape = [
  q{X},
  q{X},
  q{X},
  q{X},
];

my $horse_shape = [
  q{X},
  q{X},
  q{X},
];

my $cow_shape = [
  q{XXX},
];

my $unicorn_shape = [
  q{X  },
  q{ XX},
];

our $sheep   = Animal->new('sheep',   $sheep_shape);
our $pig     = Animal->new('pig',     $pig_shape);
our $rabbit  = Animal->new('rabbit',  $rabbit_shape);
our $horse   = Animal->new('horse',   $horse_shape);
our $cow     = Animal->new('cow',     $cow_shape);
our $unicorn = Animal->new('unicorn', $unicorn_shape);

our @animals = (
  [ 'sheep',   $sheep   ],
  [ 'pig',     $pig     ],
  [ 'rabbit',  $rabbit  ],
  [ 'horse',   $horse   ],
  [ 'cow',     $cow     ],
  [ 'unicorn', $unicorn ],
);

1;
