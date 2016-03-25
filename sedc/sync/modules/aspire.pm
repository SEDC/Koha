=head
This perl module is for connecting to aspire databases.
=cut

package Modules::Aspire;
use Modern::Perl;
use DBI;
use Data::Dumper;
use modules::config;

#apt-get libperl-dbd-odbc
sub getDBH()
{
    my $config = Modules::Config->getConfig('garfield');
    my $dbh = DBI->connect( 'dbi:ODBC:DSN='.$config->{'dsn'}, $config->{'username'}, $config->{'password'} );
    return $dbh;
    #  select "ident", "lastname", "firstname", "schoolc from stugrp_active";
}

sub getUsers()
{
    my ($self, $patronType) = @_;
    if($patronType eq 'student')
    {
        my $sth = getDBH->prepare("select rtrim(ltrim(ident)) as ident, lastname, firstname, schoolc from stugrp_active");
        $sth->execute;
        my $students = $sth->fetchall_hashref('ident');
        #$sth->close;
        return $students;
    }
}

sub getStudentTest()
{
    my %studentTest;
    $studentTest{'132'}{schoolc} = '124';
    $studentTest{'123'}{lastname} = 'John';
    $studentTest{'123'}{firstname} = 'Smith';
    $studentTest{'123'}{ident} = '123';

    return %studentTest;
    #print Dumper(%studentTest);
}

sub updateBorrowers()
{
    #Existing Borrowers
    #Check for changes
    print "$_: key is the same\n";
    #build sql statement
    #return sql statement

}

#getTeachers

=head
select a.ident, a.firstname, a.lastname, a.schoolc, d.phnnumber, a.homecity, a.gender, a.homezip, a.homeaddr1, a.advisor,
CONVERT( VARCHAR(11), a.birthdate, 120 ) AS DateOfBirth, d.gradyear
from stugrp_active a
left join studemo d on d.ident = a.ident
=cut
#

1;
