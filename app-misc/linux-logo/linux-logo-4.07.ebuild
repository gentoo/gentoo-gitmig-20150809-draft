# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/linux-logo/linux-logo-4.07.ebuild,v 1.1 2003/08/30 00:33:51 seemant Exp $

MY_P=${PN/-/_}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Displays an ansi or an ascii logo and some system information."
HOMEPAGE="http://www.deater.net/weave/vmwprod/linux_logo/" 
SRC_URI="http://www.deater.net/weave/vmwprod/linux_logo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"

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

src_install() {
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
