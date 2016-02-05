=head
This perl module is for connecting to aspire databases.

=cut

use strict;
use Modern::Perl;
use DBI;
package Sync::Aspire;
#apt-get libperl-dbd-odbc
sub getDBH()
{
    my $host = "";
    my $user = "";
    my $passwd = "";
    my $db = "";
    my $mydsn = "";

    #my $dbh = DBI->connect('dbi:ODBC:DSN=mydsn', 'user', 'passwd');
    my $dbh = DBI ->connect('dbi:ODBC:DSN=aspire', $user, $passwd);
    return $dbh;
    #  select "ident", "lastname", "firstname", "schoolc from stugrp_active";
}

#getStudents


#getTeachers
#

1;