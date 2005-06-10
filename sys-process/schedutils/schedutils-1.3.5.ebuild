# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/schedutils/schedutils-1.3.5.ebuild,v 1.3 2005/06/10 01:09:32 vapier Exp $

DESCRIPTION="Utilities for manipulating kernel schedular parameters"
HOMEPAGE="http://tech9.net/rml/schedutils"
SRC_URI="http://tech9.net/rml/${PN}/packages/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

src_compile() {
	emake \
		CFLAGS="${CFLAGS}" \
		PREFIX=/usr \
		|| die "Make failed"
}

src_install() {
	dodir /usr/bin /usr/share/man/man1 /usr/share/doc
	make install PREFIX="${D}"/usr || die "Install failed"
}
