#!/usr/bin/perl

package Moosey;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Moosey', @args);
  $self->setShape( [
    'X X',
    ' X ',
  ] );
  return $self;
}

1;
