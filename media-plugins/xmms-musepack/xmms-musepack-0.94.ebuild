# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-musepack/xmms-musepack-0.94.ebuild,v 1.1 2003/03/15 09:24:50 jje Exp $

DESCRIPTION="This plugin for XMMS can play audio files which are encoded with Andree Buschmann's encoder Musepack. These files have the filename postfixes mpc, mp+ or mpp."
HOMEPAGE="http://sourceforge.net/projects/mpegplus/"
SRC_URI="mirror://sourceforge/mpegplus/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=">=media-sound/xmms-1.2.7-r15"

src_compile() {
	# Makefile uses ARCH when calling gcc.
	ARCH="${CFLAGS}"
	emake || die
}

src_install() {
	exeinto `xmms-config --input-plugin-dir`
	doexe ${P}.so
}

