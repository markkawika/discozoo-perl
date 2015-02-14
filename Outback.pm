#!/usr/bin/perl

package Outback;

use Animal;

my $kangaroo_shape = [
  q{X   },
  q{ X  },
  q{  X },
  q{   X},
];

my $platypus_shape = [
  q{XX },
  q{ XX},
];

my $crocodile_shape = [
  q{XXXX},
];

my $koala_shape = [
  q{XX},
  q{ X},
];

my $cockatoo_shape = [
  q{X },
  q{ X},
  q{ X},
];

my $tiddalik_shape = [
  q{ X },
  q{X X},
];

our $kangaroo  = Animal->new('kangaroo',  $kangaroo_shape);
our $platypus  = Animal->new('platypus',  $platypus_shape);
our $crocodile = Animal->new('crocodile', $crocodile_shape);
our $koala     = Animal->new('koala',     $koala_shape);
our $cockatoo  = Animal->new('cockatoo',  $cockatoo_shape);
our $tiddalik  = Animal->new('tiddalik',  $tiddalik_shape);

our @animals = (
  [ 'kangaroo',  $kangaroo  ],
  [ 'platypus',  $platypus  ],
  [ 'crocodile', $crocodile ],
  [ 'koala',     $koala     ],
  [ 'cockatoo',  $cockatoo  ],
  [ 'tiddalik',  $tiddalik  ],
);

1;
