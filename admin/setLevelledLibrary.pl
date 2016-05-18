#!/usr/bin/perl
use Modern::Perl;

use CGI qw ( -utf8 );
use C4::Auth;
use CGI::Cookie;
use C4::Output;

my $input = new CGI;
my $referer = $input->referer();

my ( $template, $loggedinuser, $cookie, $flags ) = get_template_and_user(
    {
        template_name   => "intranet-main.tt",
            query           => $input,
            type            => "intranet",
            authnotrequired => 0,
            flagsrequired   => { catalogue => 1, },
    }
);

my $session = C4::Auth::get_session($input->cookie("CGISESSID"));
if(!$session->param("levelledLibraryMode"))
{
    $session->param( "levelledLibraryMode" => "1" );
}
else
{
    $session->param( "levelledLibraryMode" => "0" );
}
#Return user back to page they were on
print $input->redirect(-url=>$referer);

output_html_with_http_headers $input, $cookie, $template->output;