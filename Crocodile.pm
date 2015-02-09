#!/usr/bin/perl

package Crocodile;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Crocodile', @args);
  $self->setShape( [
    'XXXX',
  ] );
  return $self;
}

1;
