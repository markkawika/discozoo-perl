#!/usr/bin/perl

package Sasquatch;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Sasquatch', @args);
  $self->setShape( [
    'X',
    'X',
  ] );
  return $self;
}

1;
