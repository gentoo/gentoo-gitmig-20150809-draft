# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/towitoko/towitoko-2.0.7-r1.ebuild,v 1.2 2004/07/17 10:14:36 dholm Exp $

IUSE="static moneyplex"

DESCRIPTION="This library provides a driver for using Towitoko smartcard readers under UNIX environment."
SRC_URI="http://www.geocities.com/cprados/files/${P}.tar.gz"
HOMEPAGE="http://www.geocities.com/cprados/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

src_compile() {
	local myconf

	myconf="--enable-devfs"
	use moneyplex && myconf="${myconf} --disable-atr-check"

	econf \
		`use_enable static` \
		`use_enable moneyplex win32-com` \
		${myconf} || die "econf failed"
	emake || die
}

src_install() {
	einstall || die
}

pkg_postinst() {
	if ! use moneyplex
	then
		einfo "If you want to use the moneyplex home banking software from"
		einfo "http://www.matrica.de"
		einfo "then please re-emerge this package with 'moneyplex' in USE"
	fi
}
