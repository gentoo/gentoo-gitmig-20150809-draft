# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/patchage/patchage-0.4.1.ebuild,v 1.1 2008/07/09 09:02:51 aballier Exp $

EAPI=1

inherit eutils

DESCRIPTION="Modular patch bay for audio and MIDI systems"
HOMEPAGE="http://wiki.drobilla.net/Patchage"
SRC_URI="http://download.drobilla.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alsa -dbus debug lash"

RDEPEND=">=media-libs/raul-0.5.0
	>=x11-libs/flowcanvas-0.5.0
	dev-cpp/glibmm
	dev-cpp/libglademm
	dev-cpp/libgnomecanvasmm
	dev-libs/boost
	>=media-sound/jack-audio-connection-kit-0.107
	lash? ( >=media-sound/lash-0.5.2 )
	alsa? ( media-libs/alsa-lib )
	dbus? ( dev-libs/dbus-glib )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc43.patch"
}

src_compile() {
	econf $(use_enable debug) \
		$(use_enable debug pointer-debug) \
		$(use_enable alsa ) \
		$(use_enable lash) \
		$(use_enable dbus jack-dbus)
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README
}
