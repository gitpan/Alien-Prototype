package Alien::Prototype;

###############################################################################
# Required inclusions.
###############################################################################
use strict;
use warnings;
use Carp;
use File::Copy qw(copy);
use File::Path qw(mkpath);
use File::Find qw(find);
use File::Basename qw(dirname);

###############################################################################
# Version number.
###############################################################################
our $PROTOTYPE_VERSION = '1.5.1';
our $VERSION = '1.5.1.1';

###############################################################################
# Subroutine:   version()
###############################################################################
# Return the Prototype version number.
#
# Not to be confused with the 'Alien::Prototype' version number (which is the
# version number of the Perl wrapper).
###############################################################################
sub version {
    return $PROTOTYPE_VERSION;
}

###############################################################################
# Subroutine:   path()
###############################################################################
# Returns the path to the available copy of the Prototype JS library.
###############################################################################
sub path {
    my $base = $INC{'Alien/Prototype.pm'};
    $base =~ s{\.pm$}{};
    return $base;
}

###############################################################################
# Subroutine:   install($destdir)
# Parameter:    $destdir        - Destination directory
###############################################################################
# Installs the Prototype JS library into the given '$destdir'.  Throws a fatal
# exception on errors.
###############################################################################
sub install {
    my ($class, $destdir) = @_;
    if (!-d $destdir) {
        mkpath( [$destdir] ) || croak "can't create '$destdir'; $!";
    }
    my $path = $class->path();

    # Install JS files
    my @files = grep { -f $_ } glob "$path/*.js";
    foreach my $file (@files) {
        copy( $file, $destdir ) || croak "can't copy '$file' to '$destdir'; $!";
    }
}

1;

=head1 NAME

Alien::Prototype - installing and finding Prototype JS library

=head1 SYNOPSIS

  use Alien::Prototype;
  ...
  $version = Alien::Prototype->version();
  $path    = Alien::Prototype->path();
  ...
  Alien::Prototype->install( $my_destination_directory );

=head1 DESCRIPTION

Please see L<Alien> for the manifesto of the Alien namespace.

=head1 METHODS

=over

=item version()

Return the Prototype version number. 

Not to be confused with the C<Alien::Prototype> version number (which is
the version number of the Perl wrapper). 

=item path()

Returns the path to the available copy of the Prototype JS library. 

=item install($destdir) Parameter:    $destdir        - Destination directory

Installs the Prototype JS library into the given C<$destdir>. Throws a
fatal exception on errors. 

=back

=head1 AUTHOR

Graham TerMarsch (cpan@howlingfrog.com)

=head1 LICENSE

Copyright (C) 2007, Graham TerMarsch.  All rights reserved.

This is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=head1 SEE ALSO

http://www.prototypejs.org/,
L<Alien>.

=cut
