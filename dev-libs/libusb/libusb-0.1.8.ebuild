# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libusb/libusb-0.1.8.ebuild,v 1.16 2004/10/23 06:25:55 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Userspace access to USB devices"
HOMEPAGE="http://libusb.sourceforge.net/"
SRC_URI="mirror://sourceforge/libusb/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc alpha amd64 ~ia64 ppc64 ppc-macos"
IUSE="debug doc"

DEPEND="sys-devel/libtool
	doc? ( app-text/openjade
		~app-text/docbook-sgml-dtd-3.1 )"

src_unpack(){
	unpack ${A}
	# needed by libgphoto2, see bug #45889
	cd ${S}; epatch ${FILESDIR}/libusb-0.1.8-amd64-fPIC.patch

	if use ppc || use ppc-macos ; then
		aclocal || die
		autoconf || die
		automake --add-missing || die
	fi
}

src_compile() {
	local myconf

	# keep this otherwise libraries will not have .so extensions
	( use macos || use ppc-macos ) \
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
