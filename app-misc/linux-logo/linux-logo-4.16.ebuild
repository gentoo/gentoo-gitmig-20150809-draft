# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/linux-logo/linux-logo-4.16.ebuild,v 1.5 2007/08/25 16:38:58 beandog Exp $

inherit eutils

MY_P=${PN/-/_}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A utility that displays an ANSI/ASCII logo and some system information"
HOMEPAGE="http://www.deater.net/weave/vmwprod/linux_logo/"
SRC_URI="http://www.deater.net/weave/vmwprod/linux_logo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~mips ppc sparc x86"
IUSE="nls"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

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

	sed -i \
		-e '/C_OPTS/s: -O2 : $(CFLAGS) :' \
		-e '/@strip/d' \
		Makefile || die
	gunzip linux_logo.1.gz || die
}

src_compile() {
	emake || die
}

src_install() {
	dobin linux_logo || die
	doman linux_logo.1

	dodoc BUGS CHANGES README README.CUSTOM_LOGOS TODO USAGE LINUX_LOGO.FAQ

	if use nls ; then
		dodir /usr/share/locale
		make INSTALLDIR="${D}"/usr/share/locale -C po install || die
	fi

	newinitd "${FILESDIR}"/${PN}.initscript ${PN}
	newconfd "${FILESDIR}"/${PN}.conf ${PN}
}

pkg_postinst() {
	echo
	elog "Linux_logo ebuild for Gentoo comes with two Gentoo logos."
	elog ""
	elog "To display the first Gentoo logo type: linux_logo -L 3"
	elog "To display the second Gentoo logo type: linux_logo -L 4"
	elog "To display all the logos available type: linux_logo -L list."
	elog ""
	elog "To start linux_logo on boot, please type:"
	elog "   rc-update add linux-logo default"
	elog "which uses the settings found in"
	elog "   /etc/conf.d/linux-logo"
	echo
}
