# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/patchage/patchage-0.4.0.ebuild,v 1.1 2008/05/29 08:46:53 aballier Exp $

DESCRIPTION="Modular patch bay for audio and MIDI systems"
HOMEPAGE="http://wiki.drobilla.net/Patchage"
SRC_URI="http://download.drobilla.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alsa debug jack lash"

RDEPEND=">=media-libs/raul-0.4.0
	>=x11-libs/flowcanvas-0.4.0
	dev-cpp/glibmm
	dev-cpp/libglademm
	dev-cpp/libgnomecanvasmm
	dev-libs/boost
	jack? ( >=media-sound/jack-audio-connection-kit-0.107 )
	lash? ( >=media-sound/lash-0.5.2 )
	alsa? ( media-libs/alsa-lib )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf $(use_enable debug) \
		$(use_enable debug pointer-debug) \
		$(use_enable alsa ) \
		$(use_enable jack enable-jack) \
		$(use_enable jack) \
		$(use_enable lash)
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README
}
