# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kmetronome/kmetronome-0.10.0.ebuild,v 1.2 2011/02/02 04:33:40 tampakrap Exp $

EAPI=3
inherit kde4-base

DESCRIPTION="MIDI based metronome using ALSA sequencer"
HOMEPAGE="http://kmetronome.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DEPEND="
	media-libs/alsa-lib
	media-sound/drumstick
"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_configure() {
	mycmakeargs=(
		-DSTATIC_DRUMSTICK=OFF
	)

	kde4-base_src_configure
}
