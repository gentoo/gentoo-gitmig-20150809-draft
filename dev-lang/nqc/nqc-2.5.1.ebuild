# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nqc/nqc-2.5.1.ebuild,v 1.8 2005/03/22 23:45:47 ciaranm Exp $

My_PV="`echo $PV|cut -d. -f1,2`.r`echo $PV|cut -d. -f3`"
My_P="${PN}-${My_PV}"
S=${WORKDIR}/${My_P}
DESCRIPTION="Not Quite C - C-like compiler for Lego Mindstorms"
SRC_URI="http://www.baumfamily.org/nqc/release/${My_P}.tgz"
HOMEPAGE="http://www.baumfamily.org/nqc/"

SLOT="0"
LICENSE="MPL-1.0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	${#NQC_SERIAL} && NQC_SERIAL="/dev/ttyS0"
	sed -e "s:/usr/local/bin:${D}/usr/bin:" -e "s:/usr/local/man:${D}/usr/share/man:" -e "s:-O6:${CFLAGS}:" < Makefile >makefile
	# emake doesn't work
	DEFAULT_SERIAL_NAME=\"${NQC_SERIAL}\" make || die
}

src_install() {
	make DESTDIR=${D} install
	dodoc history.txt readme.txt scout.txt test.nqc
}

pkg_postinst() {
	einfo "To change the default serial name for nqc (/dev/ttyS0) set"
	einfo "the environment variable NQC_SERIAL and reemerge nqc, e.g.:"
	einfo " NQC_SERIAL='/dev/ttyS1' emerge nqc"
}
