# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bottlerocket/bottlerocket-0.04c.ebuild,v 1.1 2003/05/14 20:57:09 agriffis Exp $

IUSE=""

DESCRIPTION="CLI interface to the X-10 Firecracker Kit"
HOMEPAGE="http://mlug.missouri.edu/~tymm/"
SRC_URI="http://mlug.missouri.edu/~tymm/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND=""

src_compile() {
	econf --with-x10port=/dev/firecracker || die 'econf failed'
	emake || die 'emake failed'
}

src_install() {
	einstall || die 'einstall failed'
	dodoc README
}

pkg_postinst() {
	einfo
	einfo "Be sure to create a /dev/firecracker symlink to the"
	einfo "serial port that has the Firecracker serial interface"
	einfo "installed on it."
	einfo
}
