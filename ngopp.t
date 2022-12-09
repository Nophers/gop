#!/usr/bin/perl

use strict;
use warnings;

# Set the dimensions of the grid
my $rows = 30;
my $cols = 30;

# Create an empty grid of zeroes
my @grid = ();
for my $i (0 .. $rows-1) {
  for my $j (0 .. $cols-1) {
    $grid[$i][$j] = 0;
  }
}

# Randomly initialize the grid with alive and dead cells
for my $i (0 .. $rows-1) {
  for my $j (0 .. $cols-1) {
    $grid[$i][$j] = int(rand(2));
  }
}

# Infinite loop
while (1) {
  # Print the grid
  for my $i (0 .. $rows-1) {
    for my $j (0 .. $cols-1) {
      print $grid[$i][$j] ? '#' : '.';
    }
    print "\n";
  }

  # Create a new empty grid
  my @new_grid = ();
  for my $i (0 .. $rows-1) {
    for my $j (0 .. $cols-1) {
      $new_grid[$i][$j] = 0;
    }
  }

  # Apply the rules of the game to update the grid
  for my $i (0 .. $rows-1) {
    for my $j (0 .. $cols-1) {
      # Count the number of live neighbors
      my $neighbors = 0;
      for my $x ($i-1 .. $i+1) {
        for my $y ($j-1 .. $j+1) {
          # Skip the current cell
          next if $x == $i && $y == $j;

          # Wrap around if the indices are out of bounds
          $x = $x < 0 ? $rows-1 : $x >= $rows ? 0 : $x;
          $y = $y < 0 ? $cols-1 : $y >= $cols ? 0 : $y;

          # Add the value of the neighbor to the count
          $neighbors += $grid[$x][$y];
        }
        }
    
        # Apply the rules of the game
        if ($grid[$i][$j]) {
          $new_grid[$i][$j] = $neighbors == 2 || $neighbors == 3 ? 1 : 0;
        } else {
          $new_grid[$i][$j] = $neighbors == 3 ? 1 : 0;
        }

        }
    }

    # Update the grid
    @grid = @new_grid;

    # Wait for a short time
    sleep 1;
}