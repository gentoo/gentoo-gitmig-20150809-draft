# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gphoto2/gphoto2-2.1.1.ebuild,v 1.1 2003/02/12 15:46:59 spider Exp $

inherit libtool
inherit flag-o-matic

IUSE="nls jpeg"

S=${WORKDIR}/${P}
DESCRIPTION="free, redistributable digital camera software application"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.bz2"
HOMEPAGE="http://www.gphoto.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND=">=dev-libs/libusb-0.1.6
	=dev-libs/glib-1.2*
	>=sys-libs/zlib-1.1.4
	ncurses? ( dev-libs/cdk )
	aalib? ( 
		media-libs/aalib 
		media-libs/jpeg )
	readline? ( sys-libs/readline )
	dev-libs/popt
	>=media-libs/libgphoto2-2.1.1"

src_compile() {

	elibtoolize
	aclocal

	# -pipe does no work
	filter-flags -pipe

	local myconf
	use nls || myconf="${myconf} --disable-nls"
	use ncurses || myconf="${myconf} --without-cdk"
	use aalib || myconf="${myconf} --without-aalib --without-jpeg"
	use readline ||  myconf="${myconf} --without-readline"

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
