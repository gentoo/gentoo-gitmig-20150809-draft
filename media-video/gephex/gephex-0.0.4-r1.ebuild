# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gephex/gephex-0.0.4-r1.ebuild,v 1.4 2005/07/07 04:49:52 caleb Exp $

inherit eutils

MY_P=${P/_/}
DESCRIPTION="GePhex is a modular video effect framework."
HOMEPAGE="http://www.gephex.org"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"


IUSE="static mmx aalib"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

S="${WORKDIR}/${MY_P}"

DEPEND="virtual/x11
	=x11-libs/qt-3*
	>=media-libs/libsdl-1.2.6-r3
	>=media-libs/libpng-1.2.5-r4
	>=media-libs/sdl-ttf-2.0.6
	>=media-libs/alsa-lib-0.9.8
	>=media-video/avifile-0.7.38.20030710
	aalib?	( >=media-libs/aalib-1.4_rc4-r2 )"

RDEPEND=${DEPEND}

src_compile() {
	cd ${S}
	epatch ${FILESDIR}/0.0.4-alsa-api-fix.patch || die
	epatch ${FILESDIR}/0.0.4-makefile.in.patch || die
	epatch ${FILESDIR}/0.0.4-disable-glx.patch || die
	local myconf
	myconf="--with-gnu-ld"
	econf \
	`use_enable mmx` \
	`use_enable static` \
	${myconf} \
	|| die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README TODO

	einfo "Please read /usr/share/doc/gephex/html/documentation.html to get started."

}
