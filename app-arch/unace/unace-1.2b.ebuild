S="${WORKDIR}/${PN}"
DESCRIPTION="ACE unarchiver"
SRC_URI="http://wilma.vub.ac.be/~pdewacht/${P}.tar.gz"
HOMEPAGE="http://www.winace.com/"

SLOT="1"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp unix/makefile .
	cp unix/gccmaked .
}

src_compile() {
	sed -e "s/^CFLAGS = -O.*/CFLAGS = -Wall ${CFLAGS}/g" \
		-e "s/-DCASEINSENSE//g" \
		< makefile > makefile.new
	mv -f makefile.new makefile

	emake dep
	emake
}

src_install() {
	dobin unace
	dodoc readme.txt changes.log
}
