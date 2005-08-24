# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/k3guitune/k3guitune-0.5.ebuild,v 1.2 2005/08/24 15:56:54 greg_g Exp $

inherit kde eutils

DESCRIPTION="A program for KDE that lets you tune musical instruments."
HOMEPAGE="http://home.planet.nl/~lamer024/k3guitune.html"
SRC_URI="http://home.planet.nl/~lamer024/files/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="alsa arts oss"

DEPEND="alsa? ( media-libs/alsa-lib )"

need-kde 3

src_unpack() {
	kde_src_unpack

	use arts || epatch "${FILESDIR}/${P}-configure.patch"
}

src_compile() {
	# jack support needs a version of bio2jack not released yet.
	local myconf="$(use_enable alsa) $(use_enable arts)
	              $(use_enable oss) --disable-jack"

	kde_src_compile
}
