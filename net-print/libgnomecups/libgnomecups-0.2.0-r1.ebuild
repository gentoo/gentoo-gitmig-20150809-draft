# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/libgnomecups/libgnomecups-0.2.0-r1.ebuild,v 1.1 2005/08/04 18:38:33 metalgod Exp $

inherit eutils

DESCRIPTION="GNOME cups library"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	net-print/cups"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

src_unpack() {

	unpack ${A}
	cd ${S}
	#patch for bug "89886"
	epatch ${FILESDIR}/enablenet.patch

}

src_compile() {
	CFLAGS="${CFLAGS} `gnome-config --cflags gdk_pixbuf`"

	./configure \
			--host=${CHOST} \
			--prefix=/usr \
			--sysconfdir=/etc \
			--enable-static=no \
			--localstatedir=/var/lib || die "configure failure. please report to
			http://bugs.gentoo.org"
	emake || die "make failed"

}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS COPYING* NEWS README
}
