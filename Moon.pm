#!/usr/bin/perl

package Moon;

use Animal;

my $moonkey_shape = [
  q{X  },
  q{X X},
  q{  X},
];

my $lunar_tick_shape = [
  q{ X },
  q{   },
  q{ X },
  q{X X},
];

my $tribble_shape = [
  q{ X },
  q{XXX},
];

my $moonicorn_shape = [
  q{X },
  q{XX},
];

my $luna_moth_shape = [
  q{X X},
  q{   },
  q{ X },
];

my $jade_rabbit_shape = [
  q{X },
  q{  },
  q{ X},
];

our $moonkey     = Animal->new('moonkey',     $moonkey_shape);
our $lunar_tick  = Animal->new('lunar_tick',  $lunar_tick_shape);
our $tribble     = Animal->new('tribble',     $tribble_shape);
our $moonicorn   = Animal->new('moonicorn',   $moonicorn_shape);
our $luna_moth   = Animal->new('luna_moth',   $luna_moth_shape);
our $jade_rabbit = Animal->new('jade_rabbit', $jade_rabbit_shape);

our @animals = (
  [ 'moonkey',     $moonkey     ],
  [ 'lunar_tick',  $lunar_tick  ],
  [ 'tribble',     $tribble     ],
  [ 'moonicorn',   $moonicorn   ],
  [ 'luna_moth',   $luna_moth   ],
  [ 'jade_rabbit', $jade_rabbit ],
);

1;
