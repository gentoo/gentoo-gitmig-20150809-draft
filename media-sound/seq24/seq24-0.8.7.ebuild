# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/seq24/seq24-0.8.7.ebuild,v 1.2 2007/07/06 16:36:56 flameeyes Exp $

inherit eutils

IUSE="jack lash"
DESCRIPTION="Seq24 is a loop based MIDI sequencer with focus on live performances."
HOMEPAGE="http://www.filter24.org/seq24/"
SRC_URI="http://www.filter24.org/seq24/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=media-libs/alsa-lib-0.9.0
	>=dev-cpp/gtkmm-2.4
	jack? ( >=media-sound/jack-audio-connection-kit-0.90.0 )
	lash? ( >=media-sound/lash-0.5.0 )"

pkg_setup() {
	if ! built_with_use --missing true media-libs/alsa-lib midi; then
		eerror ""
		eerror "To be able to build ${CATEGORY}/${PN} with ALSA support you"
		eerror "need to have built media-libs/alsa-lib with midi USE flag."
		die "Missing midi USE flag on media-libs/alsa-lib"
	fi
}

src_compile() {
	econf \
		$(use_enable jack jack-support) \
		$(use_enable lash) \
		--disable-alsatest \
		|| die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README RTC SEQ24
}
