#!/usr/bin/perl

package Platypus;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Platypus', @args);
  $self->setShape( [
    'XX ',
    ' XX',
  ] );
  return $self;
}

1;
