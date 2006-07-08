# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/seq24/seq24-0.8.6.ebuild,v 1.2 2006/07/08 19:32:21 lu_zero Exp $

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

src_compile() {
	econf \
		$(use_enable jack jack-support) \
		$(use_enable lash) \
		|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README RTC SEQ24
}
