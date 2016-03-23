=head
This perl module is calling Koha modules
=cut

package Modules::Koha;
use Modern::Perl;
use DBI;
use C4::Context;
use Data::Dumper;



sub getDBH()
{
    my $dbh  = C4::Context->dbh;
}

sub getBorrowers()
{
     my $sth = getDBH->prepare("SELECT * FROM borrowers");
        $sth->execute();
        my $borrowers = $sth->fetchall_hashref('borrowernumber');

        print Dumper($borrowers);

        #check to see if id exists probably use in sync.pl
        if(exists $borrowers->{'48'})
        {
            print "HI" . "\n";
        }

        #while (my $ref = $sth->fetchrow_hashref()) {
        #    print "Found a row: id = $ref->{'borrowernumber'}, name = $ref->{'firstname'}\n";
        #}
        $sth->finish();

        # Disconnect from the database.
        getDBH->disconnect();
}

1; #means module is true.