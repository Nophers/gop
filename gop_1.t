# Set the number of rows and columns
my $rows = 50;
my $cols = 50;

# Create the initial grid of cells
my @grid = ();
for my $i (0 .. $rows - 1) {
  for my $j (0 .. $cols - 1) {
    $grid[$i][$j] = rand() < 0.5 ? 1 : 0;
  }
}

# Main game loop
while (1) {
  # Print the current state of the grid
  print_grid(\@grid);

  # Calculate the next state of the grid
  my @new_grid = ();
  for my $i (0 .. $rows - 1) {
    for my $j (0 .. $cols - 1) {
      my $alive_neighbors = count_alive_neighbors(\@grid, $i, $j);

      if ($grid[$i][$j] == 1) {
        # Any live cell with fewer than two live neighbors dies
        # Any live cell with two or three live neighbors lives on to the next generation
        # Any live cell with more than three live neighbors dies
        $new_grid[$i][$j] = $alive_neighbors < 2 || $alive_neighbors > 3 ? 0 : 1;
      } else {
        # Any dead cell with exactly three live neighbors becomes a live cell
        $new_grid[$i][$j] = $alive_neighbors == 3 ? 1 : 0;
      }
    }
  }

  # Update the grid with the new state
  @grid = @new_grid;
}

# Count the number of alive neighbors for a given cell
sub count_alive_neighbors {
  my ($grid, $i, $j) = @_;

  my $count = 0;
  for my $row ($i - 1 .. $i + 1) {
    for my $col ($j - 1 .. $j + 1) {
      # Ignore the current cell and cells outside the grid
      next if $row < 0 || $row >= $rows || $col < 0 || $col >= $cols || ($row == $i && $col == $j);

      $count++ if $grid->[$row][$col] == 1;
    }
  }

  return $count;
}

# Print the current state of the grid
sub print_grid {
  my ($grid) = @_;

  for my $i (0 .. $rows - 1) {
    for my $j (0 .. $cols - 1) {
      print $grid->[$i][$j] == 1 ? 'x' : ' ';
    }
    print "\n";
  }

  print "\n";
  sleep(1);
}
