# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gephex/gephex-0.4.1.ebuild,v 1.1 2004/11/05 08:24:06 zypher Exp $

DESCRIPTION="GePhex is a modular video effect framework."
HOMEPAGE="http://www.gephex.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

IUSE="aalib avi mmx mpeg png sdl static"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/x11
	>=x11-libs/qt-3
	>=media-libs/libsdl-1.2.6-r3
	>=media-libs/sdl-image-1.2.3
	>=media-libs/libpng-1.2.5-r4
	>=media-libs/sdl-ttf-2.0.6
	>=media-libs/alsa-lib-0.9.8
	>=media-video/avifile-0.7.38.20030710
	aalib?	( >=media-libs/aalib-1.4_rc4-r2 )"

RDEPEND=${DEPEND}

src_compile() {
	cd ${S}
	local myconf
	myconf="--with-gnu-ld"
	econf \
	`use_enable mmx` \
	`use_enable static` \
	`use_with sdl` \
	`use_with png LIBPNG` \
	`use_with mpeg MPEG3` \
	`use_with avi AVIFILE` \
	${myconf} \
	|| die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
	einfo "Please read /usr/share/doc/gephex/html/documentation.html to get started."

}
