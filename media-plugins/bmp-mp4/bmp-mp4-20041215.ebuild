# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/bmp-mp4/bmp-mp4-20041215.ebuild,v 1.4 2005/08/23 21:42:08 chainsaw Exp $

IUSE=""
MY_P=${PN}_${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="BMP plugin to play unencrypted MP4/AAC audio files"
HOMEPAGE="http://fondriest.frederic.free.fr/realisations/"
SRC_URI="http://fondriest.frederic.free.fr/fichiers/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~ppc"

DEPEND=">=media-sound/beep-media-player-0.9.7
	>=sys-devel/automake-1.8.0
	sys-devel/autoconf"

src_compile() {
	ewarn "This package contains private copies of faad2 and libmp4 which are linked statically into the final plugin."
	ewarn "Any existing installations of these will be ignored."
	ebegin "Building configure script (this will take a while)"
		ACLOCAL=aclocal-1.8 AUTOMAKE=automake-1.8 autoreconf -ifs --warnings=none &> /dev/null || die
	eend $?
	econf || die
	emake
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
}
