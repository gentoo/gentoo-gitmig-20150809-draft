# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lrmi/lrmi-0.7.ebuild,v 1.3 2003/06/22 05:10:31 seemant Exp $

IUSE=""
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
