# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/yaboot/yaboot-1.3.6-r1.ebuild,v 1.5 2002/07/20 19:25:39 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PPC Bootloader"
SRC_URI="http://penguinppc.org/projects/yaboot/${P}.tar.gz"
HOMEPAGE="http://penguinppc.org/projects/yaboot/"
DEPEND="sys-apps/powerpc-utils sys-apps/hfsutils"
RDEPEND=""
KEYWORDS="ppc -x86 -sparc -sparc64"
MAKEOPTS='PREFIX=/usr MANDIR=share/man'
SLOT="0"
LICENSE="GPL"

pkg_setup() {
	if [ ${ARCH} != "ppc" ] ; then
		eerror "Sorry, this is a PPC only package."
		die "Sorry, this as a PPC only pacakge."
	fi
}


src_compile() {
	export -n CFLAGS
	export -n CXXFLAGS
	emake ${MAKEOPTS} || die
}

src_install () {
	make ROOT=${D} ${MAKEOPTS} install || die
}
