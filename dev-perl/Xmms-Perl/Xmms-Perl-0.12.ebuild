inherit perl-module eutils

S=${WORKDIR}/${P}
DESCRIPTION="A  Perl extension interface to XMMS."
HOMEPAGE="http://www.cpan.org/modules/by-module/Xmms/${P}.readme"
SRC_URI="http://www.cpan.org/modules/by-module/Xmms/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="media-sound/xmms 
		dev-perl/MP3-Info
		dev-perl/Term-ReadLine-Perl"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}
	# MPEG::MP3Info was renamed to MP3::Info
	epatch ${FILESDIR}/Xmms-Perl-0.12-MP3Info.diff
}
