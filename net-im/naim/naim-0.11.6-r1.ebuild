# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/naim/naim-0.11.6-r1.ebuild,v 1.2 2003/07/25 21:12:07 raker Exp $

IUSE="debug"

DESCRIPTION="An ncurses based AOL Instant Messenger."
SRC_URI="http://shell.n.ml.org/n/naim/${P}.tar.gz"
HOMEPAGE="http://naim.n.ml.org/"

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

	dodoc AUTHORS BUGS ChangeLog NEWS doc/course.hlp doc/naim.hlp
}
