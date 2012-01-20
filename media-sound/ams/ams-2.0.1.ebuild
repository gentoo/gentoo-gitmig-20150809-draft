# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ams/ams-2.0.1.ebuild,v 1.4 2012/01/20 23:03:41 ssuominen Exp $

EAPI=4
inherit autotools eutils flag-o-matic multilib

DESCRIPTION="Alsa Modular Software Synthesizer"
HOMEPAGE="http://alsamodular.sourceforge.net"
SRC_URI="mirror://sourceforge/alsamodular/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="media-libs/alsa-lib
	media-sound/jack-audio-connection-kit
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	media-libs/ladspa-sdk
	media-libs/libclalsadrv
	!dev-ruby/amrita"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README THANKS"

src_prepare() {
	epatch "${FILESDIR}"/${P}-dl.patch
	eautoreconf
}

src_configure() {
	append-ldflags -L/usr/$(get_libdir)/qt4
	econf
}
