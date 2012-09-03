# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sidplayfp/sidplayfp-0.3.1.ebuild,v 1.2 2012/09/03 15:00:05 flameeyes Exp $

EAPI=4
inherit autotools-utils

DESCRIPTION="A sidplay2 fork with resid-fp"
HOMEPAGE="http://sourceforge.net/projects/sidplay-residfp/"
SRC_URI="mirror://sourceforge/sidplay-residfp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa oss pulseaudio"

RDEPEND=">=media-libs/libsidplayfp-0.3.5
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog README TODO )

src_configure() {
	local output=wav
	use oss && output=oss
	use alsa && output=alsa
	use pulseaudio && output=pulse

	local myeconfargs=( --enable-driver=${output} )

	autotools-utils_src_configure
}
