# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-musepack/xmms-musepack-1.1_alpha10.ebuild,v 1.2 2004/11/14 19:10:41 eradicator Exp $

IUSE=""

MY_P="${P/_alpha/-alpha}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="XMMS plugin to play audio files encoded with Andree Buschmann's encoder Musepack (mpc, mp+, mpp)"
HOMEPAGE="http://www.musepack.net"
SRC_URI="http://www.musepack.net/downloads/linux/plugins/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND="media-sound/xmms
	media-libs/libmusepack"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i 's:-O2 -march=i686 -pipe:${CFLAGS}:g' Makefile
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	exeinto `xmms-config --input-plugin-dir`
	doexe libmpc.so
	dodoc README
}
