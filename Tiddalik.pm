#!/usr/bin/perl

package Tiddalik;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Tiddalik', @args);
  $self->setShape( [
    ' X ',
    'X X',
  ] );
  return $self;
}

1;
