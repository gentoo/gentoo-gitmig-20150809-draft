# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gphoto2/gphoto2-2.1.1-r1.ebuild,v 1.1 2003/05/11 11:12:33 liquidx Exp $

inherit libtool flag-o-matic

IUSE="nls jpeg readline ncurses aalib"

S=${WORKDIR}/${P}
DESCRIPTION="free, redistributable digital camera software application"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.bz2"
HOMEPAGE="http://www.gphoto.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

# jpeg useflag -> exif support
# aalib -> needs libjpeg
DEPEND=">=dev-libs/libusb-0.1.6
	dev-libs/popt
	>=media-libs/libgphoto2-2.1.1-r2
	ncurses? ( dev-libs/cdk )
	aalib? ( media-libs/aalib 
		media-libs/jpeg )
	jpeg? (	media-libs/libexif )
	readline? ( sys-libs/readline )"


src_compile() {

	elibtoolize
	
	aclocal
	# -pipe does no work
	filter-flags -pipe

	local myconf
	use nls \
		|| myconf="${myconf} --disable-nls"

	# command-line frontend
	use ncurses \
		&& myconf="${myconf} --with-cdk-prefix=/usr" \
		|| myconf="${myconf} --without-cdk"

	use aalib \
		&& myconf="${myconf} --with-jpeg-prefix=/usr" \
		|| myconf="${myconf} --without-aalib --without-jpeg"
		
	use jpeg \
		&& myconf="${myconf} --with-exif-prefix=/usr" \
		|| myconf="${myconf} --without-exif" 
		
	use readline \
		||  myconf="${myconf} --without-readline"

	econf ${myconf}
	emake || die
}

src_install() {

	einstall
		gphotodocdir=${D}/usr/share/doc/${PF} \
		HTML_DIR=${D}/usr/share/doc/${PF}/sgml \
		|| die

	dodoc ChangeLog NEWS* README AUTHORS COPYING
	rm -rf ${D}/usr/share/doc/${PF}/sgml/gphoto2
}
