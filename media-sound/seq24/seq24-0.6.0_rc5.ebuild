# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/seq24/seq24-0.6.0_rc5.ebuild,v 1.1 2005/01/09 09:59:11 jnc Exp $

IUSE="jack"
MY_P=${PF/\_/\-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Seq24 is a loop based MIDI sequencer with focus on live performances."
HOMEPAGE="http://www.filter24.org/seq24/"
SRC_URI="http://www.filter24.org/seq24/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=media-libs/alsa-lib-0.9.0
	=dev-cpp/gtkmm-2.2*
	jack? ( media-sound/jack-audio-connection-kit )"

src_compile() {
	econf $(use_enable jack jack-support) || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README RTC SEQ24
}
