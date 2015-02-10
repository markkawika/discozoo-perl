#!/usr/bin/perl

package Northern;

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

my $moosey_shape = [
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

our $bear      = Animal->new('bear', $bear_shape, 2, 3);
our $skunk     = Animal->new('skunk', $skunk_shape, 3, 2);
our $beaver    = Animal->new('beaver', $beaver_shape, 3, 3);
our $moosey    = Animal->new('moosey', $moosey_shape, 3, 2);
our $fox       = Animal->new('fox', $fox_shape, 3, 2);
our $sasquatch = Animal->new('sasquatch', $sasquatch_shape, 1, 2);

1;
