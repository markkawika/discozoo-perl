#!/usr/bin/perl

package Beaver;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Beaver', @args);
  $self->setShape( [
    '  X',
    'XX ',
    '  X',
  ] );
  return $self;
}

1;
