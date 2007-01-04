# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libhydrogen/libhydrogen-0.8.1_beta5.ebuild,v 1.12 2007/01/04 15:12:59 flameeyes Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit autotools

MY_P=${P/_/}
DESCRIPTION="Linux Drum Machine - Library"
HOMEPAGE="http://hydrogen.sourceforge.net/"
SRC_URI="mirror://sourceforge/hydrogen/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="alsa"

RDEPEND="virtual/x11 \
	>=media-libs/audiofile-0.2.3 \
	alsa? ( media-libs/alsa-lib ) \
	media-sound/jack-audio-connection-kit"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	eautoreconf
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog FAQ README TODO
}
