=head
This perl module is for connecting to aspire databases.

=cut

package Modules::Aspire;
use Modern::Perl;
use DBI;
use Data::Dumper;

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
sub getStudents()
{
    my $sth = getDBH->prepare("select ident, lastname, firstname, schoolc from stugrp_active");
    $sth->execute;
    my $students = $sth->fetchall_arrayref;

    print Dumper($students);

    #my @row;
    #while (@row = $sth->fetchrow_array) {
    #   $row[0] =~ s/^\s+|\s+$//g;
    #   #Remove newline when in production - Josh
    #   print $row[0]. " " .$row[1] . "\n";
    #}
}