# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/linux-logo/linux-logo-4.12.ebuild,v 1.8 2005/08/04 08:08:21 blubb Exp $

inherit eutils

MY_P=${PN/-/_}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A utility that displays an ANSI/ASCII logo and some system information"
HOMEPAGE="http://www.deater.net/weave/vmwprod/linux_logo/"
SRC_URI="http://www.deater.net/weave/vmwprod/linux_logo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~mips ppc sparc x86"
IUSE="nls"

DEPEND=""
RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	echo "./logos/gentoo.logo" >> logo_config
	cp "${FILESDIR}"/gentoo.logo "${S}"/logos/

	epatch "${FILESDIR}"/${PN}-4.07-gentoo-logo.patch
	sed -i -e 's:.*Trying to open .*::' linux_logo.c

	if ! use nls ; then
		sed -i 's:cd po && $(MAKE):echo:' Makefile
	fi
}

src_compile() {
	make || die
}

src_install() {
	dobin linux_logo || die
	doman linux_logo.1.gz

	dodoc BUGS CHANGES README README.CUSTOM_LOGOS TODO USAGE LINUX_LOGO.FAQ

	if use nls ; then
		dodir /usr/share/locale
		make INSTALLDIR="${D}"/usr/share/locale -C po install || die
	fi

	newinitd ${FILESDIR}/${PN}.initscript ${PN}
	newconfd ${FILESDIR}/${PN}.conf ${PN}
}

pkg_postinst() {
	echo
	einfo "Linux_logo ebuild for Gentoo comes with two Gentoo logos."
	einfo ""
	einfo "To display the first Gentoo logo type: linux_logo -L 3"
	einfo "To display the second Gentoo logo type: linux_logo -L 4"
	einfo "To display all the logos available type: linux_logo -L list."
	einfo ""
	einfo "To start linux_logo on boot, please type:"
	einfo "   rc-update add linux-logo default"
	einfo "which uses the settings found in"
	einfo "   /etc/conf.d/linux-logo"
	echo
}
