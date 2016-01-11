#!/usr/bin/perl

#TODO: prints borrower table
  use Modern::Perl;
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
