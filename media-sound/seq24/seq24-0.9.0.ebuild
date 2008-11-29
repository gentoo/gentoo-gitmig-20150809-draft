# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/seq24/seq24-0.9.0.ebuild,v 1.1 2008/11/29 13:27:14 aballier Exp $

EAPI=2

inherit eutils

DESCRIPTION="Seq24 is a loop based MIDI sequencer with focus on live performances."
HOMEPAGE="https://edge.launchpad.net/seq24/"
SRC_URI="http://edge.launchpad.net/seq24/trunk/${PV}/+download/${P}.tar.bz2"

IUSE="jack lash"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=media-libs/alsa-lib-0.9.0[midi]
	>=dev-cpp/gtkmm-2.4
	>=dev-libs/libsigc++-2.2
	jack? ( >=media-sound/jack-audio-connection-kit-0.90.0 )
	lash? ( >=media-sound/lash-0.5.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		$(use_enable jack jack-support) \
		$(use_enable lash) \
		--disable-alsatest \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README RTC SEQ24
}
