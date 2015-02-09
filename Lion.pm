#!/usr/bin/perl

package Lion;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Lion', @args);
  $self->setShape( [
    'XXX',
  ] );
  return $self;
}

1;
