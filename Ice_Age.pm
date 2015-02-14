#!/usr/bin/perl

package Ice_Age;

use Animal;

my $wooly_rhino_shape = [
  q{  X },
  q{X  X},
  q{ X  },
];

my $giant_sloth_shape = [
  q{X  },
  q{  X},
  q{X X},
];

my $dire_wolf_shape = [
  q{ X  },
  q{X  X},
  q{ X  },
];

my $saber_tooth_shape = [
  q{X  },
  q{  X},
  q{ X },
];

my $mammoth_shape = [
  q{ X },
  q{X  },
  q{  X},
];

my $akhlut_shape = [
  q{  X},
  q{X  },
  q{  X},
];

our $wooly_rhino = Animal->new('wooly_rhino', $wooly_rhino_shape);
our $giant_sloth = Animal->new('giant_sloth', $giant_sloth_shape);
our $dire_wolf   = Animal->new('dire_wolf',   $dire_wolf_shape);
our $saber_tooth = Animal->new('saber_tooth', $saber_tooth_shape);
our $mammoth     = Animal->new('mammoth',     $mammoth_shape);
our $akhlut      = Animal->new('akhlut',      $akhlut_shape);

our @animals = (
  [ 'wooly_rhino', $wooly_rhino ],
  [ 'giant_sloth', $giant_sloth ],
  [ 'dire_wolf',   $dire_wolf   ],
  [ 'saber_tooth', $saber_tooth ],
  [ 'mammoth',     $mammoth     ],
  [ 'akhlut',      $akhlut      ],
);

1;
