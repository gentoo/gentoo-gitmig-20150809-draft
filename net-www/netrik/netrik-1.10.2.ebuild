S=${WORKDIR}/${P}
DESCRIPTION="A text based web browser with no ssl support."
HOMEPAGE="http://netrik.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-1"

DEPENDS=">=sys-libs/ncurses-5.1
		 >=sys-libs/zlib-1.1.3
		 nls? ( sys-devel/gettext )"

src_unpack() {
 unpack ${A} || die
 }

src_compile() {
 local myconf
 econf \
 	--prefix=/usr || die "Configure failed"
	emake || die "Compile problem"
}

src_install() {
	make prefix=${D}/usr datadir=${D}/usr/share mandir=${D}/usr/share/man libdir=${D} install \
	|| die "Unablr to do install"
}
	
