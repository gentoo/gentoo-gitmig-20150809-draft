# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-musepack/xmms-musepack-0.94.ebuild,v 1.4 2004/02/19 09:56:15 eradicator Exp $

DESCRIPTION="XMMS plugin to play audio files encoded with Andree Buschmann's encoder Musepack (mpc, mp+, mpp)"
HOMEPAGE="http://sourceforge.net/projects/mpegplus/"
SRC_URI="mirror://sourceforge/mpegplus/${P}.tar.bz2"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-sound/xmms-1.2.7-r15"

src_compile() {
	# Makefile uses ARCH when calling gcc
	emake ARCH="${CFLAGS}" || die
}

src_install() {
	exeinto `xmms-config --input-plugin-dir`
	doexe ${P}.so
}
