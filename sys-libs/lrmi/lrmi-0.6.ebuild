# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lrmi/lrmi-0.6.ebuild,v 1.1 2002/10/21 17:52:19 hanno Exp $

DESCRIPTION="LRMI is a library for calling real mode BIOS routines under Linux."
HOMEPAGE="http://www.sourceforge.net/projects/lrmi/"
KEYWORDS="~x86"
SLOT="0"
LICENSE="MIT"
DEPEND="virtual/glibc"
RDEPEND=""
SRC_URI="mirror://sourceforge/lrmi/${P}.tar.gz"
S=${WORKDIR}/${P}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {
	dobin vbetest
	insinto /usr/lib
	doins liblrmi.so
        insinto /usr/include
	doins lrmi.h vbe.h
}
