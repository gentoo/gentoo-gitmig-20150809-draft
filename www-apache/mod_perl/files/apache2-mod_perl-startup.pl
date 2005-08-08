use Apache2 ();

use lib qw(/home/httpd/perl);

# enable if the mod_perl 1.0 compatibility is needed
use Apache::compat ();
# preload all mp2 modules
use ModPerl::MethodLookup;
ModPerl::MethodLookup::preload_all_modules();

use ModPerl::Util (); #for CORE::GLOBAL::exit

use Apache::RequestRec ();
use Apache::RequestIO ();
use Apache::RequestUtil ();

use Apache::ServerRec ();
use Apache::ServerUtil ();
use Apache::Connection ();
use Apache::Log ();

use APR::Table ();

use ModPerl::Registry ();

use Apache::Const -compile => ':common';
use APR::Const -compile => ':common';

# end of mod_perl2 stuff

#use Apache::Session ();
use CGI ();
use CGI::Cookie ();
use DBI;
#use Apache::Perldoc ();
use Apache::Status ();
use HTML::Mason ();
use HTML::Mason::ApacheHandler ();
use MasonX::Apache2Handler ();

1;
