package Art;
use warnings;
use strict;
use diagnostics;
use Imager;
use Imager::Color;

sub generate_file_name {
    join '', @_[ map{ rand @_ } 1 .. shift ];
}

sub generate_hex_code_value {
    my @values = ('0' .. '8', 'A' .. 'F');
    join '', map $values[rand @values], 1 .. 6;
}

sub generate_lines {
    my ($xsize, $ysize, $biggest) = @_;
    for (;;) { #infinite loop.
        my $randcolor = generate_hex_code_value();
        print "Line color generated: $randcolor\n";
        $Art::img->line(
            color => $randcolor,
            x1    => int rand $xsize,
            y1    => int rand $ysize,
            x2    => int rand $xsize,
            y2    => int rand $ysize,
            aa    => 0
        );
        my $subnum = int rand $biggest;
        if ($subnum == 1) {
            last;
        }
    }
    return 1;
}

sub generate_boxes {
    my ($xsize, $ysize, $biggest) = @_;
    for (;;) { #infinite loop.
        my $randcolor = generate_hex_code_value();
        print "Box color generated: $randcolor\n";
        $Art::img->box(
            xmin   => 0,
            ymin   => 0,
            xmax   => int rand $xsize,
            ymax   => int rand $ysize,
            filled => int rand 1,
            color  => $randcolor
        );
        my $subnum = int rand $biggest;
        if ($subnum == 1) {
            last;
        }
    }
    return 1;
}

sub generate_arcs {
    my ($xsize, $ysize, $biggest) = @_;
    my $radius = ($xsize + $ysize) / 3;
    for (;;) { #infinite loop.
        my $randcolor = generate_hex_code_value();
        print "Arc color generated: $randcolor\n";
        $Art::img->arc(
            color  => $randcolor,
            x      => int rand $xsize,
            y      => int rand $ysize,
            r      => int rand $radius,
            d1     => int rand 361,
            d2     => int rand 361,
            filled => int rand 1
        );
        my $subnum = int rand $biggest;
        if ($subnum == 1) {
            last;
        }
    }
    return 1;
}

sub generate_circles {
    my ($xsize, $ysize, $biggest) = @_;
    my $radius = ($xsize + $ysize) / 3;
    for (;;) { #infinite loop.
        my $randcolor = generate_hex_code_value();
        print "Circle color generated: $randcolor\n";
        $Art::img->circle(
            color  => $randcolor,
            x      => int rand $xsize,
            y      => int rand $ysize,
            r      => int rand $radius,
            filled => int rand 1
        );
        my $subnum = int rand $biggest;
        if ($subnum == 1) {
            last;
        }
    }
    return 1;
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
                    print "Lines?\n";
                    my $iflines = <>;
                    print "Boxes?\n";
                    my $ifboxes = <>;
                    print "Arcs?\n";
                    my $ifarcs = <>;
                    print "Circles?\n";
                    my $ifcircles = <>;

                    chomp $color;
                    chomp $iflines;
                    chomp $ifboxes;
                    chomp $ifarcs;
                    chomp $ifcircles;

                    if ($iflines !~ m/^y/i and $ifboxes !~ m/^y/i and $ifarcs !~ m/^y/i and $ifcircles !~ m/^y/i) {
                        print 'You must choose at least one shape.';
                        exit 0;
                    }

                    my $filename = generate_file_name(8, 'A'..'Z');
                    print "File name generated: $filename\n";

                    my $biggest = [$size[0] => $size[1]] -> [$size[0] <= $size[1]];
                    our $img = Imager->new(
                        xsize    => $size[0],
                        ysize    => $size[1],
                        channels => 4
                    );

                    if ($color =~ m/^random$/i) {
                        my $randomcolor = generate_hex_code_value();
                        $img->box(
                            xmin   => 0,
                            ymin   => 0,
                            xmax   => $size[0],
                            ymax   => $size[1],
                            filled => 1,
                            color  => $randomcolor
                        );
                    } else {
                        $img->box(
                            xmin   => 0,
                            ymin   => 0,
                            xmax   => $size[0],
                            ymax   => $size[1],
                            filled => 1,
                            color  => $color
                        );
                    }

                    if ($iflines =~ m/^y/i) {
                        generate_lines($size[0] + 1, $size[1] + 1, $biggest * 5);
                    }

                    if ($ifboxes =~ m/^y/i) {
                        generate_boxes($size[0] + 1, $size[1] + 1, $biggest * 5);
                    }

                    if ($ifarcs =~ m/^y/i) {
                        generate_arcs($size[0] + 1, $size[1] + 1, $biggest * 5);
                    }

                    if ($ifcircles =~ m/^y/i) {
                        generate_circles($size[0] + 1, $size[1] + 1, $biggest * 5);
                    }

                    $img->write(
                        file => "art/shapes/$filename.bmp"
                    ) or die "Cannot save $filename", $img->errstr;

                    print "Created art as $filename.bmp at size $size[0]x$size[1] with a background color of \'$color\'";
                } else {
                    print 'That is not a valid color.';
                    exit 0;
                }
            } else {
                print 'That is not a valid size.';
                exit 0;
            }
        } else {
            print 'That is not a valid size.';
            exit 0;
        }
    } else {
        print 'That is not a valid size.';
        exit 0;
    }
    return 1;
}

run();

'''
== CHANGELOG ==
=== 0.2 ===
* Updated to Python 3.4.

=== 0.1 ===
* Initial release

'''
