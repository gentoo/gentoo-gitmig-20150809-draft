inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl Net::RawIP - Raw IP packets manipulation Module"
SRC_URI="http://www.cpan.org/modules/by-module/Net/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/"

DEPEND="net-libs/libpcap"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86"
