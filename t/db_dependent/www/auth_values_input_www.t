#!/usr/bin/perl

# Copyright 2012 C & P Bibliography Services
#
# This is free software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
#
# This is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# Koha; if not, write to the Free Software Foundation, Inc., 59 Temple Place,
# Suite 330, Boston, MA  02111-1307 USA
#

use Modern::Perl;
use utf8;
use Test::More;
use Test::WWW::Mechanize;
use Data::Dumper;
use XML::Simple;
use JSON;
use File::Basename;
use File::Spec;
use POSIX;
use Encode;

my $testdir = File::Spec->rel2abs( dirname(__FILE__) );

my $koha_conf = $ENV{KOHA_CONF};
my $xml       = XMLin($koha_conf);

eval{
    use C4::Context;
};
if ($@) {
    plan skip_all => "Tests skip. You must have a working Context\n";
}


my $user     = $ENV{KOHA_USER} || $xml->{config}->{user};
my $password = $ENV{KOHA_PASS} || $xml->{config}->{pass};
my $intranet = $ENV{KOHA_INTRANET_URL};

my $mysql_on = ProgProcesses('mysql');


if ($mysql_on < 2) {
    plan skip_all => "Tests skip. You must start Mysql to do those tests\n";
}

if (not defined $intranet) {
    plan skip_all => "Tests skip. You must set env. variable KOHA_INTRANET_URL to do tests\n";
}


$intranet =~ s#/$##;

my $agent = Test::WWW::Mechanize->new( autocheck => 1 );
my $jsonresponse;

# -------------------------------------------------- LOAD RECORD

$agent->get_ok( "$intranet/cgi-bin/koha/mainpage.pl", 'connect to intranet' );
$agent->form_name('loginform');
$agent->field( 'password', $password );
$agent->field( 'userid',   $user );
$agent->field( 'branch',   '' );
$agent->click_ok( '', 'login to staff client' );
$agent->get_ok( "$intranet/cgi-bin/koha/mainpage.pl", 'load main page' );

$agent->get_ok( "$intranet/cgi-bin/koha/admin/authorised_values.pl", 'Connect to Authorized values page' );
$agent->get_ok( "$intranet/cgi-bin/koha/admin/authorised_values.pl?op=add_form", 'Open to create a new category' );
$agent->form_name('Aform');
$agent->field('authorised_value', 'επιμεq');
$agent->field('lib_opac', 'autdesc2');
$agent->field('lib', 'desc1');
$agent->field('category', '学協会μμ');
$agent->field('branches', '');
$agent->click_ok( '', "Create new auth category and value" );

$agent->get_ok( "$intranet/cgi-bin/koha/admin/authorised_values.pl", 'Return to Authorized values page' );
$agent->get_ok( "$intranet/cgi-bin/koha/admin/authorised_values.pl?searchfield=学協会μμ&offset=0", 'Search the values inserted' );
my $text = $agent->text() ;
#Tests on UTF-8
ok ( ( length(Encode::encode_utf8($text)) != length($text) ) , 'UTF-8 are multi-byte. Good') ;
ok ($text =~  m/学協会μμ/, 'UTF-8 (Asia) chars are correctly present. Good');
ok ($text =~  m/επιμεq/, 'UTF-8 (Greek) chars are correctly present. Good');
my @links = $agent->links;
my $id_to_del ='';
foreach my $dato (@links){
    my $link = $dato->url;
    if ($link =~  m/op=delete_confirm\&searchfield=学協会μμ/){
        $link =~  m/(.*&id=?)(\d{1,})(&.*)/;
        $id_to_del = $2;
        last;
    };
}
if ($id_to_del) {
    $agent->get_ok( "$intranet/cgi-bin/koha/admin/authorised_values.pl?op=delete_confirmed&searchfield=学協会μμ&id=$id_to_del", 'UTF_8 auth. value deleted' );
}else{
    ok($id_to_del ne undef, "error, link to delete nor working");
}

done_testing();

sub ProgProcesses {
   return scalar grep /$_[0]/, (split /\n/, `ps -aef`);
}