# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgphoto2/libgphoto2-2.1.1-r2.ebuild,v 1.1 2003/05/11 11:09:29 liquidx Exp $

inherit libtool
inherit flag-o-matic
MAKEOPTS="-j1"
# or the documentation fails. bah!

IUSE="nls doc jpeg"

S=${WORKDIR}/${P}
DESCRIPTION="free, redistributable digital camera software application"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.bz2"
HOMEPAGE="http://www.gphoto.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND=">=dev-libs/libusb-0.1.6
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
	#emake || die
}

src_install() {
	
	einstall
		gphotodocdir=${D}/usr/share/doc/${PF} \
		HTML_DIR=${D}/usr/share/doc/${PF}/sgml \
		|| die

	dodoc ChangeLog NEWS* README AUTHORS TESTERS MAINTAINERS HACKING CHANGES
	rm -rf ${D}/usr/share/doc/${PF}/sgml/gphoto2
}
