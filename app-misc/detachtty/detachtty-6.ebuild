# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/detachtty/detachtty-6.ebuild,v 1.1 2003/06/12 08:12:11 mkennedy Exp $

DESCRIPTION="detachtty allows the user to attach/detach from interactive processes across the network.  It is similar to GNU Screen"
HOMEPAGE="http://packages.debian.org/unstable/admin/detachtty.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/d/detachtty/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

S=${WORKDIR}/${P}

src_compile() {
	make || die
}

src_install() {
	dobin detachtty attachtty
	doman detachtty.1
	dosym /usr/share/man/man1/detachtty.1 /usr/share/man/man1/attachtty.1
	dodoc INSTALL README
}

pkg_postinst() {
	einfo ">>> See the README in addition to the man-pages for more examples and ideas"
}
