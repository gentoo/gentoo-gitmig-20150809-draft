IUSE="ipv6"

DESCRIPTION="ircII is an IRC and ICB client that runs under most UNIX platforms."
SRC_URI="ftp://ircii.warped.com/pub/ircII/${P}.tar.bz2"
HOMEPAGE="http://www.eterna.com.au/ircii/"

DEPEND=">=dev-libs/glib-1.2
	sys-libs/ncurses
	>=sys-apps/sed-4"
RDEPEND="( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A}
}

src_compile() {

#	use socks || myconf="${myconf} --with-socks"

	use ipv6 && myconf="${myconf} --enable-ipv6"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--sysconfdir=/etc \
		${myconf} || die "./configure failed"

	emake || die
}

src_install() {

	prepalldocs
	dodoc ChangeLog INSTALL NEWS README
	dodoc doc/Copyright doc/crypto doc/VERSIONS doc/ctcp
}
