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

our $bear      = Animal->new('bear',      $bear_shape);
our $skunk     = Animal->new('skunk',     $skunk_shape);
our $beaver    = Animal->new('beaver',    $beaver_shape);
our $moosey    = Animal->new('moosey',    $moosey_shape);
our $fox       = Animal->new('fox',       $fox_shape);
our $sasquatch = Animal->new('sasquatch', $sasquatch_shape);

1;
