P=ispell-it
S=${WORKDIR}/${P}
DESCRIPTION="Loris Palmerini - Italian dictionary for ispell."
HOMEPAGE="http://members.xoom.virgilio.it/trasforma/ispell/"
SRC_URI="http://members.xoom.virgilio.it/trasforma/ispell/${P}${PV}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="app-text/ispell"
RDEPEND=""

src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/ispell
	doins italian.hash italian.aff

	dodoc collab.txt AUTHORS CAMBI CHANGES COPYNG DA-FARE.txt FUSIONE.txt INSTALL
}
