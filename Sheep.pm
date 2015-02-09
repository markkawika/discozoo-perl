#!/usr/bin/perl

package Sheep;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Sheep', @args);
  $self->setShape( [
    'XXXX',
  ] );
  return $self;
}

1;
