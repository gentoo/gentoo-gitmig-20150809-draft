# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/macosd/macosd-0.1.7.ebuild,v 1.1 2004/09/25 00:07:58 pvdabeel Exp $

inherit eutils

DESCRIPTION="On-Screen-Display frontend for pbbuttonsd (only for PPC Laptops)."
HOMEPAGE="http://www.rocklinux-consulting.de/oss/macosd/"
SRC_URI="http://dl.rocklinux-consulting.de/oss/macosd/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""
DEPEND="virtual/x11
	>=app-laptop/pbbuttonsd-0.5.2-r1
	>=x11-libs/evas-1.0.0.20040529_pre13
	>=x11-libs/xosd-2.2.5"
RDEPEND="$DEPEND"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-include-fix.diff
}

src_compile() {
	./configure \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die "emake failed"
}

src_install() {
	dodir /usr/share/macosd
	dodir /usr/bin
	einstall || die
	dodoc README
}

pkg_postinst() {
	einfo "Make sure that pbbuttons is running (add it to your default runlevel)"
	einfo "and then add the following to your $HOME/.xinitrc to have macosd"
	einfo "start whenever you launch X:"
	einfo "macosd -n -t CleanOSX &"
}
