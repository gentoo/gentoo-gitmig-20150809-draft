S=${WORKDIR}/${P}
DESCRIPTION="GTK+-2.0 Hangul Input Modules"
SRC_URI="http://download.kldp.net/imhangul/${P}.tar.gz"
HOMEPAGE="http://imhangul.kldp.net"
KEYWORDS="~x86 ~ppc ~sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=x11-libs/gtk+-2.0.5"

src_compile() {
	./configure	\
		--prefix=/usr	\
		--sysconfdir=/etc || die "./configure failed"
	
	emake || die
}

src_install() {

	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		install || die
	
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS TODO
}
