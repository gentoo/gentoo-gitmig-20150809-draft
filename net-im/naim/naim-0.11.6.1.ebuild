# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/naim/naim-0.11.6.1.ebuild,v 1.1 2003/10/02 23:17:14 hillster Exp $

IUSE="debug"

DESCRIPTION="An ncurses based AOL Instant Messenger."
SRC_URI="http://site.n.ml.org/download/20030923195458/naim/${P}.tar.bz2"
HOMEPAGE="http://site.n.ml.org/info/naim/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~arm ~mips"

DEPEND=">=sys-libs/ncurses-5.2"

src_compile() {
	local myconf
	myconf="--with-gnu-ld --enable-detach"
	# --enable-profile
	# --experimental-buddy-grouping

	# by default will install to /usr/share/doc/${P}
	myconf="${myconf} --with-pkgdocdir=/usr/share/doc/${PN}-${PVR}"

	use debug && myconf="${myconf} --enable-debug"

	econf ${myconf}	|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS COPYING FAQ BUGS README NEWS ChangeLog doc/*.hlp
}
