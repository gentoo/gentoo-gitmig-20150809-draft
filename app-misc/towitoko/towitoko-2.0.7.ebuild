# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/towitoko/towitoko-2.0.7.ebuild,v 1.4 2003/07/01 22:31:32 aliz Exp $

DESCRIPTION="This library provides a driver for using Towitoko smartcard readers under UNIX environment."
SRC_URI="http://www.geocities.com/cprados/files/${P}.tar.gz"
HOMEPAGE="http://www.geocities.com/cprados/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="static"

src_compile() {
	local myconf="--enable-devfs"
	use static && myconf="${myconf} --enable-static"
	econf ${myconf}
	emake || die
}

src_install() {
	einstall
}
