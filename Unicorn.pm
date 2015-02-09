#!/usr/bin/perl

package Unicorn;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Unicorn', @args);
  $self->setShape( [
    'X  ',
    ' XX',
  ] );
  return $self;
}

1;
