# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/detachtty/detachtty-6.ebuild,v 1.7 2005/01/01 14:58:10 eradicator Exp $

DESCRIPTION="detachtty allows the user to attach/detach from interactive processes across the network.  It is similar to GNU Screen"
HOMEPAGE="http://packages.debian.org/unstable/admin/detachtty.html"
SRC_URI="mirror://debian/pool/main/d/detachtty/${P/-/_}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""
DEPEND=""

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
