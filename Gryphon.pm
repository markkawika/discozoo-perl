#!/usr/bin/perl

package Gryphon;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Gryphon', @args);
  $self->setShape( [
    'X X',
    ' X ',
  ] );
  return $self;
}

1;
