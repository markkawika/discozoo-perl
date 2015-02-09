#!/usr/bin/perl

package Skunk;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Skunk', @args);
  $self->setShape( [
    ' XX',
    'XX ',
  ] );
  return $self;
}

1;
