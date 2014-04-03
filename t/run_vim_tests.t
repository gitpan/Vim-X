use Test::More;

plan skip_all => 'soon';

use Path::Tiny;

my $iter = path( 't/lib/TestsFor' )->iterator({ recurse => 1 });

while( my $file = $iter->() ) {
    next unless $file =~ /\.pm$/ and 0;

    run_test( $file );
}

sub run_test {
    system 'vim', qw/ -V -u NONE -i NONE -N -e -s /,
        '-c' => 'perl push @INC, "lib"', 
#        '-c' => 'perl push @INC, "t/lib"', 
        '-c', "perl do '$0' or die \$@",
        '-c', "qall!";
}


