# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/macosd/macosd-0.3.1.ebuild,v 1.2 2007/01/09 06:36:27 corsair Exp $

inherit eutils

DESCRIPTION="On-Screen-Display frontend for pbbuttonsd (only for PPC Laptops)."
HOMEPAGE="http://www.exactcode.de/oss/macosd/"
SRC_URI="http://dl.exactcode.de/oss/macosd/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""
DEPEND=">=app-laptop/pbbuttonsd-0.6.8
	>=x11-libs/evas-0.9.9.027
	>=x11-libs/xosd-2.2.5
	|| (
			(
				x11-libs/libX11
				x11-libs/libXext
			)
			virtual/x11
		)"
RDEPEND="$DEPEND"

src_compile() {
	# can't use econf -- this packages uses ROCK Linux style configure
	./configure \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-xosd \
		--with-evas || die "./configure failed"

	emake || die "emake failed"
}

src_install() {
	dodir /usr/share/macosd
	dodir /usr/bin
	einstall || die
	dodoc README
}

pkg_postinst() {
	elog "Make sure that pbbuttons is running (add it to your default runlevel)"
	elog "and then add the following to your ~/.xinitrc to have macosd"
	elog "start whenever you launch X:"
	elog "macosd -t CleanOSX &"
	elog "To see a listing of available themes, run: macosd -l"
	elog "If you do not have a composite manager check out the --no-argb switch"
}

