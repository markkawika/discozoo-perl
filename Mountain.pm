#!/usr/bin/perl

package Mountain;

use Animal;

my $goat_shape = [
  q{X  },
  q{XXX},
];

my $cougar_shape = [
  q{X  },
  q{ X },
  q{X X},
];

my $elk_shape = [
  q{X X},
  q{ XX},
];

my $eagle_shape = [
  q{X },
  q{X },
  q{ X},
];

my $coyote_shape = [
  q{XX },
  q{  X},
];

my $aatxe_shape = [
  q{  X},
  q{X  },
];

our $goat   = Animal->new('goat',   $goat_shape);
our $cougar = Animal->new('cougar', $cougar_shape);
our $elk    = Animal->new('elk',    $elk_shape);
our $eagle  = Animal->new('eagle',  $eagle_shape);
our $coyote = Animal->new('coyote', $coyote_shape);
our $aatxe  = Animal->new('aatxe',  $aatxe_shape);

our @animals = (
  [ 'goat',   $goat   ],
  [ 'cougar', $cougar ],
  [ 'elk',    $elk    ],
  [ 'eagle',  $eagle  ],
  [ 'coyote', $coyote ],
  [ 'aatxe',  $aatxe  ],
);

1;
