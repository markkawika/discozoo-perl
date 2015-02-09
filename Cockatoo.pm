#!/usr/bin/perl

package Cockatoo;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Cockatoo', @args);
  $self->setShape( [
    'X ',
    ' X',
    ' X',
  ] );
  return $self;
}

1;
