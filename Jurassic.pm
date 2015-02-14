#!/usr/bin/perl

package Jurassic;

use Animal;

my $diplodocus_shape = [
  q{X  },
  q{ XX},
  q{ X },
];

my $stegosaurus_shape = [
  q{ XX },
  q{X  X},
];

my $raptor_shape = [
  q{XX },
  q{ X },
  q{  X},
];

my $t_rex_shape = [
  q{X },
  q{  },
  q{XX},
];

my $triceratops_shape = [
  q{X  },
  q{  X},
  q{X  },
];

my $dragon_shape = [
  q{X  },
  q{  X},
];

our $diplodocus  = Animal->new('diplodocus',  $diplodocus_shape);
our $stegosaurus = Animal->new('stegosaurus', $stegosaurus_shape);
our $raptor      = Animal->new('raptor',      $raptor_shape);
our $t_rex       = Animal->new('t_rex',       $t_rex_shape);
our $triceratops = Animal->new('triceratops', $triceratops_shape);
our $dragon      = Animal->new('dragon',      $dragon_shape);

our @animals = (
  [ 'diplodocus',  $diplodocus  ],
  [ 'stegosaurus', $stegosaurus ],
  [ 'raptor',      $raptor      ],
  [ 't_rex',       $t_rex       ],
  [ 'triceratops', $triceratops ],
  [ 'dragon',      $dragon      ],
);

1;
