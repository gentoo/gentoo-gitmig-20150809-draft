# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/linux_logo/linux_logo-4.02.ebuild,v 1.3 2002/09/06 21:24:13 owen Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Displays an ansi or an ascii logo and some system information."
SRC_URI="http://www.deater.net/weave/vmwprod/linux_logo/linux_logo-4.02.tar.gz"
HOMEPAGE="http://www.deater.net/weave/vmwprod/linux_logo/" 

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 ppc"

src_unpack() { 
	unpack ${A}
	cd ${S}
	gunzip linux_logo.1.gz
	cp Makefile Makefile.orig
	echo "./logos/gentoo.logo" >> logo_config
	cp ${FILESDIR}/gentoo.logo ${S}/logos/.
}

src_compile() {
	make || die
}

src_install () {
	dobin linux_logo
	doman linux_logo.1
	dodoc BUGS CHANGES COPYING README README.CUSTOM_LOGOS TODO USAGE
	dodoc LINUX_LOGO.FAQ
}

pkg_postinst() {
	einfo
	einfo "Linux_logo ebuild for Gentoo comes with a Gentoo logo."
	einfo "To display it type: linux_logo -L 3"
	einfo "To display all the logos available type: linux_logo -L list."
}
