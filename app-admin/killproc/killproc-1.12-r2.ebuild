# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/killproc/killproc-1.12-r2.ebuild,v 1.14 2003/09/06 22:08:32 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="killproc and assorted tools for boot scripts"
HOMEPAGE="http://www.suse.de/"
SRC_URI="ftp://ftp.suse.com/pub/projects/init/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="virtual/glibc"

src_unpack() {

	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig

	if [ ${ARCH} = "x86" ] ; then
		sed -e "s:-O2:${CFLAGS}:" -e "s:-m486::" Makefile.orig > Makefile
	else
		sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile
	fi
}

src_compile() {
	make || die
}

src_install() {
	into /
	dosbin checkproc startproc killproc
	into /usr
	doman *.8
	dodoc README *.lsm
}
