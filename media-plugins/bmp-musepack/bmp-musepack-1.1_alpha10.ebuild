# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/bmp-musepack/bmp-musepack-1.1_alpha10.ebuild,v 1.1 2004/11/14 14:07:16 chainsaw Exp $

inherit eutils
IUSE=""

MY_P="${P/_alpha/-alpha}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Beep Media Player plugin to play audio files encoded with Andree Buschmann's encoder Musepack (mpc, mp+, mpp)"
HOMEPAGE="http://www.musepack.net"
SRC_URI="http://www.musepack.net/downloads/linux/plugins/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

DEPEND="media-sound/beep-media-player
	>=media-libs/libmusepack-1.0.2"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}-makefile.patch
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	exeinto `beep-config --input-plugin-dir`
	doexe libmpc.so
	dodoc README
}
