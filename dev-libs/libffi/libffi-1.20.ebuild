# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libffi/libffi-1.20.ebuild,v 1.10 2004/03/14 12:21:56 mr_bones_ Exp $

DESCRIPTION="Support library for Foreign Functions Interfaces"
SRC_URI="ftp://sourceware.cygnus.com/pub/libffi/${P}.tar.gz"
HOMEPAGE="http://sources.redhat.com/libffi/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog LICENSE
}
