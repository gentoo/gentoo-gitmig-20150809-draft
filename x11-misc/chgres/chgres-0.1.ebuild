IUSE=""
DESCRIPTION="A very simple command line utility for changing X resolutions"
HOMEPAGE="http://hpwww.ec-lyon.fr/~vincent/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

SRC_URI="http://hpwww.ec-lyon.fr/~vincent/${P}.tar.gz"

DEPEND="x11-base/xfree"

src_compile() {
	emake || die
}

src_install() {
	exeinto /usr/bin
	doexe chgres 
	dodoc README
}
