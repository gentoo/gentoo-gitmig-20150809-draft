# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header

S=${WORKDIR}/${P}
DESCRIPTION="This library provides a driver for using Towitoko smartcard readers under UNIX environment."
SRC_URI="http://www.geocities.com/cprados/files/${P}.tar.gz"
HOMEPAGE="http://www.geocities.com/cprados/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="static"

DEPEND="virtual/glibc"

src_compile() {

	local myconf
	myconf="${myconf} --enable-devfs"
	use static && myconf="${myconf} --enable-static"
	econf ${myconf} || die
	emake || die

}

src_install () {

	einstall || die
}
