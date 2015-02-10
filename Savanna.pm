#!/usr/bin/perl

package Savanna;

use Animal;

my $zebra_shape = [
  q{ X },
  q{X X},
  q{ X },
];

my $hippo_shape = [
  q{X X},
  q{   },
  q{X X},
];

my $giraffe_shape = [
  q{X},
  q{X},
  q{X},
  q{X},
];

my $lion_shape = [
  q{XXX},
];

my $elephant_shape = [
  q{XX},
  q{X },
];

my $gryphon_shape = [
  q{X X},
  q{ X },
];

our $zebra    = Animal->new('zebra',    $zebra_shape);
our $hippo    = Animal->new('hippo',    $hippo_shape);
our $giraffe  = Animal->new('giraffe',  $giraffe_shape);
our $lion     = Animal->new('lion',     $lion_shape);
our $elephant = Animal->new('elephant', $elephant_shape);
our $gryphon  = Animal->new('gryphon',  $gryphon_shape);

1;
