#!/usr/bin/perl
use lib "/home/koha/eric/sedc/bin/sync";

use Modern::Perl;
use Data::Dumper;
use aspire;
my $dbhSis = Sync::Aspire->getDBH();
my $sth = $dbhSis->prepare("select ident, lastname, firstname, schoolc from stugrp_active");
$sth->execute;
my @row;
while (@row = $sth->fetchrow_array) {
   print $row[0,];
}

#print Dumper(\$sth)
#    open (FILEHANDLE, ">hash.dat") or die ("cannot open hash.dat");
#$, = "\n";
#print hash.dat @$sth;
#close hash.dat;



=head
use C4::Context;
my $dbh   = C4::Context->dbh;
my $sth = $dbh->prepare("SELECT * FROM borrowers");
$sth->execute();
while (my $ref = $sth->fetchrow_hashref()) {
    print "Found a row: id = $ref->{'surname'}, name = $ref->{'firstname'}\n";
}
$sth->finish();

# Disconnect from the database.
$dbh->disconnect();
=cut

