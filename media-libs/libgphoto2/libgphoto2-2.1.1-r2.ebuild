# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgphoto2/libgphoto2-2.1.1-r2.ebuild,v 1.10 2004/02/18 14:24:17 agriffis Exp $

inherit libtool
inherit flag-o-matic
MAKEOPTS="-j1" # or the documentation fails. bah!

DESCRIPTION="free, redistributable digital camera software application"
HOMEPAGE="http://www.gphoto.org/"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc"
IUSE="nls doc jpeg"

DEPEND=">=dev-libs/libusb-0.1.6
	dev-util/pkgconfig
	jpeg? ( >=media-libs/libexif-0.5.9 )
	doc? ( dev-util/gtk-doc )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-norpm.patch
}

src_compile() {
	elibtoolize

	local myconf

	myconf="--with-rpmbuild=/bin/false"

	use jpeg \
		&& myconf="${myconf} --with-exif-prefix=/usr" \
		|| myconf="${myconf} --without-exif"

	use nls \
		|| myconf="${myconf} --disable-nls"

	use doc \
		&& myconf="${myconf} --enable-docs" \
		|| myconf="${myconf} --disable-docs"

	econf ${myconf}
	emake || die "make failed"
}

src_install() {

	make DESTDIR=${D} \
		gphotodocdir=/usr/share/doc/${PF} \
		HTML_DIR=/usr/share/doc/${PF}/sgml \
		install || die "install failed"

	dodoc ChangeLog NEWS* README AUTHORS TESTERS MAINTAINERS HACKING CHANGES
	rm -rf ${D}/usr/share/doc/${PF}/sgml/gphoto2
}
