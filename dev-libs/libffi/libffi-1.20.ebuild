# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libffi/libffi-1.20.ebuild,v 1.6 2002/10/04 05:15:45 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Support library for Foreign Functions Interfaces"
SRC_URI="ftp://sourceware.cygnus.com/pub/libffi/${P}.tar.gz"
HOMEPAGE="http://sources.redhat.com/libffi/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog LICENSE
}
