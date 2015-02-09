#!/usr/bin/perl

package Koala;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Koala', @args);
  $self->setShape( [
    'XX',
    ' X',
  ] );
  return $self;
}

1;
