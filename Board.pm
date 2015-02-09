#!/usr/bin/perl

package Board;

use strict;
use warnings;
use English qw( -no_match_vars );
use Carp;

sub new {
  my ($class, @args) = @_;
  my $self = {
    _occupants => [],
    _layout    => [ '     ',
                    '     ',
                    '     ',
                    '     ',
                    '     ',
                  ],
  };

  bless $self, $class;
  return $self;
}

sub clone {
  my ($self) = @_;

  my $new_board = Board->new();

  my @occupants = @{ $self->{_occupants} };
  $new_board->{_occupants} = \@occupants;

  my @layout = @{ $self->{_layout} };
  $new_board->{_layout} = \@layout;

  return $new_board;
}

sub _validate_coords {
  my ($self, $x, $y) = @_;

  if ($x < 0 || $x > 4) {
    croak "X value is out of range: [$x]";
  }
  elsif ($y < 0 || $y > 4) {
    croak "Y value is out of range: [$y]";
  }
}

sub setLayout {
  my ($self, $layout) = @_;
  $self->{_layout} = $layout;
}

sub getLayout {
  my ($self) = @_;
  return $self->{_layout};
}

sub setBoardPos {
  my ($self, $x, $y, $letter) = @_;

  $self->_validate_coords($x, $y);

  my @layout = @{ $self->getLayout() };
  substr ($layout[$y], $x, 1, $letter);
  $self->setLayout(\@layout);
}

sub getBoardPos {
  my ($self, $x, $y) = @_;

  my $layout = $self->getLayout();
  return substr($layout->[$y], $x, 1);
}

sub getNameAtPos {
  my ($self, $x, $y) = @_;

  $self->_validate_coords($x, $y);

  my $id = $self->getBoardPos($x, $y);
  return $self->getOccupantNameById($id);
}


sub willAnimalFit {
  my ($self, $animal, $x, $y) = @_;

  $self->_validate_coords($x, $y);
  my $animal_height = $animal->getHeight();
  my $animal_width = $animal->getWidth();

  # Is the animal too far down or to the right?
  my $room_on_board = ((($x + $animal_width)  <= 5)
                    && (($y + $animal_height) <= 5));
  if (! $room_on_board) {
    return 0;
  }

  for (my $y2 = 0; $y2 < $animal_height; $y2++) {
    for (my $x2 = 0; $x2 < $animal_width; $x2++) {
      my $shape_char = $animal->getShapePos($x2, $y2);
      # Only test the board if the animal occupies that space
      next if $shape_char eq ' ';
      my $board_char = $self->getBoardPos($x + $x2, $y + $y2);
      if ($board_char ne ' ') {
        # This board position is occupied; the animal won't fit.
        return 0;
      }
    }
  }

  return 1;
}

sub getNumOccupants {
  my ($self) = @_;
  return (scalar @{ $self->{_occupants} });
}

sub getOccupantNameById {
  my ($self, $id) = @_;
  if ($id eq q{ }) {
    return 'empty';
  }
  elsif ($id !~ /^\d$/) {
    croak "Invalid id [$id]";
  }

  if ($id > $self->getNumOccupants()) {
    my $num_occupants = $self->getNumOccupants();
    croak "You asked for id [$id] but the max is $num_occupants";
  }
  for my $occ (@{ $self->{_occupants} }) {
    if ($occ->[0] == $id) {
      return $occ->[1];
    }
  }
}

sub addOccupant {
  my ($self, $animal_name) = @_;

  my @occupants = @{ $self->{_occupants} };
  my $num_occupants = scalar @occupants;
  my $animal_id = $num_occupants + 1;
  push @occupants, [ $animal_id, $animal_name ];
  $self->{_occupants} = \@occupants;
  return $animal_id;
}

sub insertAnimal {
  my ($self, $animal, $x, $y) = @_;

  if (! $self->willAnimalFit($animal, $x, $y)) {
    croak "Shape will not fit at ($x,$y).";
  }

  my $animal_id = $self->addOccupant($animal->getName());

  for (my $y2 = 0; $y2 < $animal->getHeight(); $y2++) {
    for (my $x2 = 0; $x2 < $animal->getWidth(); $x2++) {
      my $shape_char = $animal->getShapePos($x2, $y2);
      next if $shape_char eq ' ';
      $self->setBoardPos($x + $x2, $y + $y2, $animal_id);
    }
  }

  return $self;
}

sub printBoard {
  my ($self) = @_;

  my @layout = @{ $self->getLayout() };
  print " -----------\n";
  for my $line (@layout) {
    print q{[ } . join(q{ }, split(//, $line)) . qq{ ]\n};
  }
  print " -----------\n";
  print "\n";
  for my $occupant (@{ $self->{_occupants} }) {
    printf "%1d: %s\n", $occupant->[0], $occupant->[1];
  }
}

1;
