#!/usr/bin/perl

my @grid = ();
for my $i (0 .. 9) {
    for my $j (0 .. 9) {
        $grid[$i][$j] = int(rand(2));
    }
}

while (1) {
    # Print the current grid
    for my $i (0 .. 9) {
        for my $j (0 .. 9) {
            print $grid[$i][$j] ? '#' : ' ';
        }
        print "\n";
    }

    # Calculate the next generation
    my @next = ();
    for my $i (0 .. 9) {
        for my $j (0 .. 9) {
            # Count the number of live neighbors
            my $neighbors = 0;
            for my $ii ($i - 1 .. $i + 1) {
                for my $jj ($j - 1 .. $j + 1) {
                    # Skip the current cell
                    next if $ii == $i && $jj == $j;

                    # Wrap around if the neighbor is off the edge of the grid
                    $ii = 0 if $ii < 0;
                    $ii = 9 if $ii > 9;
                    $jj = 0 if $jj < 0;
                    $jj = 9 if $jj > 9;

                    # Count the live neighbor
                    $neighbors++ if $grid[$ii][$jj];
                }
            }

            # Apply the rules of the game of life
            if ($grid[$i][$j] && ($neighbors == 2 || $neighbors == 3)) {
                $next[$i][$j] = 1;
            } elsif (!$grid[$i][$j] && $neighbors == 3) {
                $next[$i][$j] = 1;
            } else {
                $next[$i][$j] = 0;
            }
        }
    }

    @grid = @next;
    sleep(1);
}