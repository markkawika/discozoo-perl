#!/usr/bin/perl

package Bear;

use strict;
use warnings;
use parent 'Animal';

sub new {
  my ($class, @args) = @_;

  my $self = $class->SUPER::new('Bear', @args);
  $self->setShape( [
    'XX',
    ' X',
    ' X',
  ] );
  return $self;
}

1;
