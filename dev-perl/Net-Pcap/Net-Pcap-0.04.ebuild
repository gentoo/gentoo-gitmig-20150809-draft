inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl Net::Pcap - Perl binding to the LBL pcap"
SRC_URI="http://www.cpan.org/modules/by-module/Net/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/"

DEPEND="net-libs/libpcap"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86"
