S=${WORKDIR}/${P}
DESCRIPTION="A library for converting between kanji encodings"
SRC_URI="http://ghost.math.sci.hokudai.ac.jp/misc/${PN}/${P}.tar.gz"
HOMEPAGE="http://ghost.math.sci.hokudai.ac.jp/misc/${PN}"
LICENSE="LGPL"
KEYWORDS="~x86"
SLOT=0
DEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install() {
	into /usr
	dodir /usr/include
	insinto /usr/include
	doins jconv.h

	dolib libjconv.so
	( cd ${D}/usr/lib ; chmod 755 libjconv.so )
	dolib libjconv.a

	dobin jconv
	dodir /etc/libjconv
	insinto /etc/libjconv
	doins default.conf
	dodoc README.old
	dodoc libjconv.html
}
