
inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl CGI::FastTemplate Module"
SRC_URI="http://search.cpan.org/CPAN/authors/id/J/JM/JMOORE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/JMOORE/${P}/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~ppc ~alpha ~sparc"

DEPEND="${DEPEND}
		>=dev-perl/CGI-2.78-r3"


