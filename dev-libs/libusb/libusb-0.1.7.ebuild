# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libusb/libusb-0.1.7.ebuild,v 1.6 2003/06/19 17:38:00 wwoods Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Userspace access to USB devices"
SRC_URI="mirror://sourceforge/libusb/${P}.tar.gz"
HOMEPAGE="http://libusb.sourceforge.net"

DEPEND="virtual/glibc
	doc? ( app-text/openjade =app-text/docbook-sgml-dtd-3.1-r1 )"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc ppc alpha"

src_compile() {

	local myconf

	use doc \
		&& myconf="--enable-build-docs" \
		|| myconf="--disable-build-docs"

	[ -n "${DEBUGBUILD}" ] \
		&& myconf="${myconf} --enable-debug=all" \
		|| myconf="${myconf} --disable-debug"

	econf ${myconf} || die

	make || die

}

src_install () {

	make DESTDIR=${D} install || die

	dodoc AUTHORS NEWS README

	cd doc/html
	use doc && dohtml *.html

}
