#!/usr/bin/perl

package Giraffe;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Giraffe', @args);
  $self->setShape( [
    'X',
    'X',
    'X',
    'X',
  ] );
  return $self;
}

1;
