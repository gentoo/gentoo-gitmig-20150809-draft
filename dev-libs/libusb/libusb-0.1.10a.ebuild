# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libusb/libusb-0.1.10a.ebuild,v 1.2 2005/03/23 14:08:16 liquidx Exp $

inherit eutils

DESCRIPTION="Userspace access to USB devices"
HOMEPAGE="http://libusb.sourceforge.net/"
SRC_URI="mirror://sourceforge/libusb/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos ~s390 ~sparc ~x86"
IUSE="debug doc"

DEPEND="sys-devel/libtool
	doc? ( app-text/openjade
		~app-text/docbook-sgml-dtd-4.2 )"

src_unpack(){
	unpack ${A}

	if use ppc-macos ; then
		aclocal || die
		autoconf || die
		automake --add-missing || die
	fi
}

src_compile() {
	local myconf

	# keep this otherwise libraries will not have .so extensions
	use ppc-macos \
	  && glibtoolize --force \
	  || libtoolize --force

	use doc \
		&& myconf="--enable-build-docs" \
		|| myconf="--disable-build-docs"

	use debug \
		&& myconf="${myconf} --enable-debug=all" \
		|| myconf="${myconf} --disable-debug"

	econf ${myconf} || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS NEWS README || die
	if use doc; then
		dohtml doc/html/*.html || die
	fi
}
