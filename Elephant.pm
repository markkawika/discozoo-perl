#!/usr/bin/perl

package Elephant;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Elephant', @args);
  $self->setShape( [
    'XX',
    'X ',
  ] );
  return $self;
}

1;
