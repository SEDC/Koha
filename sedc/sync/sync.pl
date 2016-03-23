#!/usr/bin/perl

use lib "/home/koha/eric/sedc/sync/";

use Modern::Perl;
use Data::Dumper;
use modules::aspire;
use modules::koha;

#Connect to the Aspire DB and get Students
my $dbhSis = Modules::Aspire->getStudents;

#Connect to the Koha DB and get borrowers(students)
my $dbhKoha = Modules::Koha->getBorrowers();

