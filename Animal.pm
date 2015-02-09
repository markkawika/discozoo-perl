#!/usr/bin/perl

package Animal;
use strict;
use warnings;

use English qw( -no_match_vars );
use Carp;

# So, a board layout is a 25-character string. We can compare board layouts
# easily with a string compare.

sub new {
  my ($class, $name) = @_;

  my $self = {
    _width  => 1,
    _height => 1,
    _name   => $name,
    _shape  => [],
  };
  bless $self, $class;
  return $self;
}

sub setHeight {
  my ($self, $height) = @_;
  $self->{_height} = $height;
  return $self;
}

sub getHeight {
  my ($self) = @_;
  return $self->{_height};
}

sub setWidth {
  my ($self, $width) = @_;
  $self->{_width} = $width;
  return $self;
}

sub getWidth {
  my ($self) = @_;
  return $self->{_width};
}

sub setName {
  my ($self, $name) = @_;
  $self->{_name} = $name;
  return $self;
}

sub getName {
  my ($self) = @_;
  return $self->{_name};
}

sub setShape {
  my ($self, $shape) = @_;
  my $shapeWidth = length($shape->[0]);
  $self->setWidth($shapeWidth);
  my $shapeHeight = scalar @{ $shape };
  $self->setHeight($shapeHeight);
  for my $shapeLine (@{ $shape }) {
    if (length($shapeLine) != $self->getWidth()) {
      croak $self->getName() . ' width does not match animal width';
    }
  }
  $self->{_shape} = $shape;
}

sub getShape {
  my ($self) = @_;
  return $self->{_shape};
}

sub getShapePos {
  my ($self, $x, $y) = @_;
  my $shape = $self->getShape();
  if ($x < $self->getWidth() && $y < $self->getHeight()) {
    return substr($shape->[$y], $x, 1);
  }
  else {
   my $name = $self->getName();
    croak "Invalid x,y for $name: ($x,$y)";
  }
}

1;
