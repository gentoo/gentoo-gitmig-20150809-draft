# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gphoto2/gphoto2-2.1.4.ebuild,v 1.7 2004/07/31 02:53:15 tgall Exp $

inherit libtool flag-o-matic

DESCRIPTION="free, redistributable digital camera software application"
HOMEPAGE="http://www.gphoto.org/"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~amd64 ~ia64 ppc64"
IUSE="nls jpeg readline ncurses aalib"

# jpeg useflag -> exif support
# aalib -> needs libjpeg
RDEPEND=">=dev-libs/libusb-0.1.6
	dev-libs/popt
	>=media-libs/libgphoto2-2.1.3
	ncurses? ( dev-libs/cdk )
	aalib? ( media-libs/aalib
		media-libs/jpeg )
	jpeg? (	media-libs/libexif )
	readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

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

	econf ${myconf} || die "econf failed"
	emake || die
}

src_install() {
	einstall \
		gphotodocdir=${D}/usr/share/doc/${PF} \
		HTML_DIR=${D}/usr/share/doc/${PF}/sgml \
		|| die

	dodoc ChangeLog NEWS* README AUTHORS COPYING
	rm -rf ${D}/usr/share/doc/${PF}/sgml/gphoto2
}
