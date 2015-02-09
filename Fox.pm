#!/usr/bin/perl

package Fox;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Fox', @args);
  $self->setShape( [
    'XX ',
    '  X',
  ] );
  return $self;
}

1;
