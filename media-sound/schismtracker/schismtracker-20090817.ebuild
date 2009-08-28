# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/schismtracker/schismtracker-20090817.ebuild,v 1.1 2009/08/28 17:38:36 ssuominen Exp $

EAPI=2

DESCRIPTION="a free reimplementation of Impulse Tracker, a program used to create high quality music"
HOMEPAGE="http://eval.sovietrussia.org//wiki/Schism_Tracker"
SRC_URI="http://${PN}.org/dl/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2 public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXv
	x11-libs/libXxf86misc
	media-libs/alsa-lib
	sys-libs/zlib
	>=media-libs/libsdl-1.2"
DEPEND="${RDEPEND}
	x11-proto/kbproto
	x11-proto/xf86miscproto"

src_configure() {
	econf \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README TODO
}
