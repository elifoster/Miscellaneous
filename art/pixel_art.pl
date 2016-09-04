package Art;
use warnings;
use strict;
use diagnostics;
use Imager;
use Imager::Color;

# Needs a better math thing for the placment of the boxes.
sub generate_file_name {
    join '', @_[ map{ rand @_ } 1 .. shift ];
}

sub generate_hex_code_value {
    my @values = ('0' .. '8', 'A' .. 'F');
    join '', map $values[rand @values], 1 .. 6;
}

sub run {
    print "How large would you like your art?\n";
    my @size = split /x/, <>, 2;
    chomp $size[1];

    if (exists $size[0]) {
        if (exists $size[1]) {
            if ($size[0] == 0 or $size[1] == 0) {
                print 'It must be at least 1x1 pixels.';
                exit 0;
            }
            if ($size[0] =~ m/\d/ and $size[1] =~ m/\d/) {
                print "What would you like your background color to be? (hex code)\n";
                my $color = <>;

                if ($color =~ m/[p{IsAlphabetic}\d]/ or $color =~ m/^#[p{IsAlphabetic}\d]/) {
                    chomp $color;

                    my $filename = generate_file_name(8, 'A'..'Z');
                    print "File name generated: $filename\n";

                    my $biggest = [$size[0] => $size[1]] -> [$size[0] <= $size[1]];
                    our $img = Imager->new(
                        xsize    => $size[0],
                        ysize    => $size[1],
                        channels => 4
                    );

                    for (;;) { #infinite loop.
                        my $randcolor = generate_hex_code_value();
                        print "Color generated: $randcolor\n";
                        $Art::img->box(
                            xmin   => 1,
                            ymin   => 1,
                            xmax   => int rand $size[0],
                            ymax   => int rand $size[1],
                            filled => 1,
                            color  => $randcolor
                        );
                        my $subnum = int rand $biggest * 5;
                        if ($subnum == 1) {
                            last;
                        }
                    }

                    $img->write(
                        file => "art/shapes/$filename.bmp"
                    ) or die "Cannot save $filename", $img->errstr;

                    print "Created art as $filename.bmp at size $size[0]x$size[1] with a background color of \'$color\'";
                }
            }
        }
    }
}

run();

