# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/linux_logo/linux_logo-4.07-r1.ebuild,v 1.2 2003/06/08 02:11:04 seemant Exp $

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="Displays an ansi or an ascii logo and some system information."
SRC_URI="http://www.deater.net/weave/vmwprod/linux_logo/${P}.tar.gz"
HOMEPAGE="http://www.deater.net/weave/vmwprod/linux_logo/" 

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	>=sys-apps/sed-4"

RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() { 
	unpack ${A}
	cd ${S}
	echo "./logos/gentoo.logo" >> logo_config
	cp ${FILESDIR}/gentoo.logo ${S}/logos/.

	epatch ${FILESDIR}/${P}-gentoo-logo.patch

	if [ -z "`use nls`" ]
	then
		sed -i 's:cd po && $(MAKE)::' Makefile
	fi
}

src_compile() {
	make || die
}

src_install() {
	dobin linux_logo
	doman linux_logo.1.gz
	
	dodoc BUGS CHANGES COPYING README README.CUSTOM_LOGOS TODO USAGE
	dodoc LINUX_LOGO.FAQ

	if use nls
	then
		dodir /usr/share/locale
		make INSTALLDIR=${D}/usr/share/locale -C po install || die
	fi
}

pkg_postinst() {
	einfo
	einfo "Linux_logo ebuild for Gentoo comes with two Gentoo logos."
	einfo "To display the first Gentoo logo type: linux_logo -L 3"
	einfo "To display the second Gentoo logo type: linux_logo -L 4"
	einfo "To display all the logos available type: linux_logo -L list."
}
