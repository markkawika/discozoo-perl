#!/usr/bin/perl

package Pig;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Pig', @args);
  $self->setShape( [
    'XX',
    'XX',
  ] );
  return $self;
}

1;
