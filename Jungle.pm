#!/usr/bin/perl

package Jungle;

use Animal;

my $monkey_shape = [
  q{X X },
  q{ X X},
];

my $toucan_shape = [
  q{ X},
  q{X },
  q{ X},
  q{ X},
];

my $gorilla_shape = [
  q{X X},
  q{X X},
];

my $panda_shape = [
  q{  X},
  q{X  },
  q{  X},
];

my $tiger_shape = [
  q{X XX},
];

my $phoenix_shape = [
  q{X  },
  q{   },
  q{  X},
];

our $monkey  = Animal->new('monkey',  $monkey_shape);
our $toucan  = Animal->new('toucan',  $toucan_shape);
our $gorilla = Animal->new('gorilla', $gorilla_shape);
our $panda   = Animal->new('panda',   $panda_shape);
our $tiger   = Animal->new('tiger',   $tiger_shape);
our $phoenix = Animal->new('phoenix', $phoenix_shape);

our @animals = (
  [ 'monkey',  $monkey  ],
  [ 'toucan',  $toucan  ],
  [ 'gorilla', $gorilla ],
  [ 'panda',   $panda   ],
  [ 'tiger',   $tiger   ],
  [ 'phoenix', $phoenix ],
);

1;
