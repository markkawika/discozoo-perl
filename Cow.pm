#!/usr/bin/perl

package Cow;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Cow', @args);
  $self->setShape( [
    'XXX',
  ] );
  return $self;
}

1;
