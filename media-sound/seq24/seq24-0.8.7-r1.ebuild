# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/seq24/seq24-0.8.7-r1.ebuild,v 1.1 2008/10/10 12:44:41 flameeyes Exp $

EAPI=2

inherit eutils

IUSE="jack lash"
DESCRIPTION="Seq24 is a loop based MIDI sequencer with focus on live performances."
HOMEPAGE="http://www.filter24.org/seq24/"
SRC_URI="http://www.filter24.org/seq24/${P}.tar.gz
	mirror://gentoo/${P}-sigc22_fix.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=media-libs/alsa-lib-0.9.0[midi]
	>=dev-cpp/gtkmm-2.4
	>=dev-libs/libsigc++-2.0
	jack? ( >=media-sound/jack-audio-connection-kit-0.90.0 )
	lash? ( >=media-sound/lash-0.5.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	# fix #220827
	if has_version ">=dev-libs/libsigc++-2.2"; then
		epatch "${WORKDIR}/${P}-sigc22_fix.patch"
	fi
}

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
