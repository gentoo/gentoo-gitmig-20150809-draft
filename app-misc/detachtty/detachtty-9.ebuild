# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/detachtty/detachtty-9.ebuild,v 1.1 2004/10/25 12:52:50 ka0ttic Exp $

MY_P="${P/-/_}"

DESCRIPTION="detachtty allows the user to attach/detach from interactive processes across the network.  It is similar to GNU Screen"
HOMEPAGE="http://packages.debian.org/unstable/admin/detachtty.html"
SRC_URI="mirror://debian/pool/main/d/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake CC="${CC:-gcc}" CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin detachtty attachtty || die
	doman detachtty.1 || die
	dosym /usr/share/man/man1/detachtty.1 /usr/share/man/man1/attachtty.1
	dodoc INSTALL README
}
