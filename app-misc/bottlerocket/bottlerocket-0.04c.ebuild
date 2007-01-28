# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bottlerocket/bottlerocket-0.04c.ebuild,v 1.9 2007/01/28 04:58:32 genone Exp $

IUSE=""

DESCRIPTION="CLI interface to the X-10 Firecracker Kit"
HOMEPAGE="http://mlug.missouri.edu/~tymm/"
SRC_URI="http://mlug.missouri.edu/~tymm/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
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
	elog
	elog "Be sure to create a /dev/firecracker symlink to the"
	elog "serial port that has the Firecracker serial interface"
	elog "installed on it."
	elog
}
