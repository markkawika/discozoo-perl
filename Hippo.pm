#!/usr/bin/perl

package Hippo;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Hippo', @args);
  $self->setShape( [
    'X X',
    '   ',
    'X X',
  ] );
  return $self;
}

1;
