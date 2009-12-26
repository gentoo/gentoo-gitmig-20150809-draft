# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ams/ams-2.0.1.ebuild,v 1.1 2009/12/26 15:35:49 ssuominen Exp $

EAPI=2
inherit flag-o-matic multilib

DESCRIPTION="Alsa Modular Software Synthesizer"
HOMEPAGE="http://alsamodular.sourceforge.net"
SRC_URI="mirror://sourceforge/alsamodular/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
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

src_configure() {
	append-ldflags -L/usr/$(get_libdir)/qt4
	econf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS
}
