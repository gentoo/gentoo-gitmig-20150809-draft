# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/darcnes/darcnes-0401-r2.ebuild,v 1.1 2004/05/10 19:02:15 mr_bones_ Exp $

inherit games

DESCRIPTION="A multi-system emulator"
HOMEPAGE="http://www.dridus.com/~nyef/darcnes/"
SRC_URI="http://www.dridus.com/~nyef/darcnes/download/dn9b${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"
IUSE="gtk svga"

DEPEND="svga? ( >=media-libs/svgalib-1.4.2 )
	virtual/x11
	gtk? ( =x11-libs/gtk+-1.2* )"

S="${WORKDIR}/${PN}"

src_compile() {
	if use svga ; then
		emake TARGET=Linux_svgalib OPTFLAGS="${CFLAGS}" || \
			die "compile target Linux_svgalib failed"
	fi
	if use gtk ; then
		emake BINFILE=gdarcnes TARGET=Linux_GTK OPTFLAGS="${CFLAGS}" || \
			die "compile target Linux_GTK failed"
	fi
	emake TARGET=Linux_X OPTFLAGS="${CFLAGS}" || \
		die "compile target Linux_X failed"
}

src_install() {
	dogamesbin darcnes || die "dogamesbin failed"
	if use gtk ; then
		dogamesbin gdarcnes || die "dogamesbin failed (gtk)"
	fi
	if use svga ; then
		dogamesbin sdarcnes || die "dogamesbin failed (svga)"
	fi
	dodoc readme
	prepgamesdirs
}
