# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pth/pth-1.4.1.ebuild,v 1.3 2002/12/09 04:21:04 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU Portable Threads"
SRC_URI="ftp://ftp.gnu.org/gnu/pth/pth-1.4.1.tar.gz"
HOMEPAGE="http://www.gnu.org/software/pth/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc "

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc ANNOUNCE AUTHORS COPYING ChangeLog NEWS README THANKS USERS
}
