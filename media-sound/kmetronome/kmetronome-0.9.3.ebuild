# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kmetronome/kmetronome-0.9.3.ebuild,v 1.1 2010/04/27 23:54:29 ssuominen Exp $

EAPI=2
# FIXME. Doesn't work with KDE_LINGUAS added
# KDE_LINGUAS="cs es fr"
inherit kde4-base

DESCRIPTION="MIDI based metronome using ALSA sequencer"
HOMEPAGE="http://kmetronome.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DEPEND="media-libs/alsa-lib
	media-sound/drumstick"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_configure() {
	mycmakeargs=(
		"-DSTATIC_DRUMSTICK=OFF"
		)

	cmake-utils_src_configure
}
