#!/usr/bin/perl

package Horse;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Horse', @args);
  $self->setShape( [
    'X',
    'X',
    'X',
  ] );
  return $self;
}

1;
