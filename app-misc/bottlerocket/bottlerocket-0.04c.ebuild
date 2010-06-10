# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bottlerocket/bottlerocket-0.04c.ebuild,v 1.11 2010/06/10 14:55:18 patrick Exp $

inherit toolchain-funcs

DESCRIPTION="CLI interface to the X-10 Firecracker Kit"
HOMEPAGE="http://www.linuxha.com/bottlerocket/"
SRC_URI="http://www.linuxha.com/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

src_compile() {
	econf --with-x10port=/dev/firecracker
	emake CC="$(tc-getCC)" || die "emake failed"
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
