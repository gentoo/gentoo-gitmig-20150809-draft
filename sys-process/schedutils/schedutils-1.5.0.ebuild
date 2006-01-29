# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/schedutils/schedutils-1.5.0.ebuild,v 1.1 2006/01/29 12:47:00 vapier Exp $

DESCRIPTION="Utilities for manipulating kernel schedular parameters"
HOMEPAGE="http://rlove.org/schedutils/"
SRC_URI="http://rlove.org/schedutils/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="!>=sys-apps/util-linux-2.13_pre"

src_compile() {
	emake \
		CFLAGS="${CFLAGS}" \
		PREFIX=/usr \
		|| die "Make failed"
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	make install PREFIX="${D}"/usr || die "Install failed"
	dodoc AUTHORS ChangeLog README
}
