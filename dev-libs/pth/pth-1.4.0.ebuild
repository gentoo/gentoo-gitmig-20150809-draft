# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pth/pth-1.4.0.ebuild,v 1.10 2003/11/25 03:32:24 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU Portable Threads"
SRC_URI="ftp://ftp.gnu.org/gnu/pth/pth-${PV}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/pth/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc ~alpha"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc ANNOUNCE AUTHORS COPYING ChangeLog NEWS README THANKS USERS
}
