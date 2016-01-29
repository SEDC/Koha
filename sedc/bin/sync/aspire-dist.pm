=head
This perl module is for connecting to aspire databases.

=cut

#db connection = return the DBH
#sybase
#getDBH


#getStudents

#getTeachers

1;
#db connection = return the DBH
#sybase
#getDBH
#205.125.67.238 1443 kohaadmin tr8t0r
package Sync::Aspire;

use Modern::Perl;
use DBI;
sub getDBH()
{
    my $host = "";
    my $user = "";
    my $passwd = "";
    my $db = "";
}

my $dbh = DBI ->connect("dbi:Sybase:server=$host, port=1443, $user, $passwd, database=$db");
return $dbh;