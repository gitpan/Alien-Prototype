use strict;
use warnings;
use Test::More tests => 2;
use Test::Exception;
use File::Path qw(rmtree);
use Alien::Prototype;

my $dir = 't/eraseme';

# Do an install and make sure that at least one file got installed properly.
Alien::Prototype->install( $dir );
foreach my $file (qw( prototype.js )) {
    ok( -e "$dir/$file", "$dir/$file exists" );
}

# Re-install into the same directory, to make sure that it doesn't choke.
lives_ok { Alien::Prototype->install($dir) };

# Clean out the test directory
rmtree( $dir );
