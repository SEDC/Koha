#!/usr/bin/perl
use lib "/home/koha/eric/sedc/sync/";
use Modern::Perl;
use Data::Dumper;
use modules::aspire;
use modules::koha;


my $patronType = 'student';

my $dbhSis = Modules::Aspire->getUsers($patronType); #Get Students from Aspire
my $dbhKoha = Modules::Koha->getBorrowers(); #Get Student(Borrowers) from Koha
my %test = Modules::Aspire->getStudentTest(); #Test function
my $testref = \%test; #Turn test into a hashref so better control
my $new; #just practicing moving one hashref into another hashref

#print Dumper($testref->{2810});
#print Dumper($dbhSis->{2810});

for ( keys $dbhSis)
{
    if ( exists $testref->{$_})
    {
        #pass if key is equal into updateBorrowers
        Modules::Aspire->updateBorrowers();
        #get returned sql statement and apend to array push
    }
    else
    {
        #New Borrowers
        #Create Borrowers
        #print "$_: not found in Koha\n";
        $new->{$_} = $dbhSis->{$_};
    }
    #print Dumper($new->{$_});

}

#execute sql statement to push changes
#execute sql statement to push new borrowers
#execute sql statement for log




################################################################################
=head
my $changesSQL;
        if($dbh['firstname'] != firstname)
        {
            $changesSQL .= " firstname = "$firstname;
        }
        if($dbh['lastname'] != dbh->{$_}{'firstname'})
        {
            $changesSQL .= " lastname = "$firstname;
        }
        push (@changes, 'update borrowers set ".$changesSQL." where borrownumber = $_');
=cut