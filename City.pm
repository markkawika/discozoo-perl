#!/usr/bin/perl

package City;

use Animal;

my $raccoon_shape = [
  q{X X },
  q{X  X},
];

my $pigeon_shape = [
  q{X  },
  q{ X },
  q{ XX},
];

my $rat_shape = [
  q{XX  },
  q{ X X},
];

my $squirrel_shape = [
  q{  X},
  q{X  },
  q{ X },
];

my $opossum_shape = [
  q{X  },
  q{X X},
];

my $sewer_turtle_shape = [
  q{XX},
];

our $raccoon      = Animal->new('raccoon',      $raccoon_shape);
our $pigeon       = Animal->new('pigeon',       $pigeon_shape);
our $rat          = Animal->new('rat',          $rat_shape);
our $squirrel     = Animal->new('squirrel',     $squirrel_shape);
our $opossum      = Animal->new('opossum',      $opossum_shape);
our $sewer_turtle = Animal->new('sewer_turtle', $sewer_turtle_shape);

our @animals = (
  [ 'raccoon',      $raccoon      ],
  [ 'pigeon',       $pigeon       ],
  [ 'rat',          $rat          ],
  [ 'squirrel',     $squirrel     ],
  [ 'opossum',      $opossum      ],
  [ 'sewer_turtle', $sewer_turtle ],
);

1;
