# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/darcnes/darcnes-0401-r2.ebuild,v 1.9 2005/03/13 08:29:51 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A multi-system emulator"
HOMEPAGE="http://www.dridus.com/~nyef/darcnes/"
SRC_URI="http://www.dridus.com/~nyef/darcnes/download/dn9b${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-ppc x86"
IUSE="gtk svga X"

DEPEND="svga? ( >=media-libs/svgalib-1.4.2 )
	!svga? ( virtual/x11 )
	X? ( virtual/x11 )
	gtk? (
		virtual/x11
		=x11-libs/gtk+-1.2* )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-gcc34.patch"
	# bug #75391
	sed -i \
		-e "s/buttons\[0\]/buttons\[\]/" ui.h \
		|| die "sed failed"
}

src_compile() {
	build_X=true
	use svga && build_X=false
	use gtk && build_X=false
	use X && build_X=true

	if use svga ; then
		emake TARGET=Linux_svgalib OPTFLAGS="${CFLAGS}" \
			|| die "compile target Linux_svgalib failed"
	fi
	if use gtk ; then
		emake BINFILE=gdarcnes TARGET=Linux_GTK OPTFLAGS="${CFLAGS}" \
			|| die "compile target Linux_GTK failed"
	fi
	if $build_X ; then
		emake TARGET=Linux_X OPTFLAGS="${CFLAGS}" \
			|| die "compile target Linux_X failed"
	fi
}

src_install() {
	if use svga ; then
		dogamesbin sdarcnes || die "dogamesbin failed (svga)"
	fi
	if use gtk ; then
		dogamesbin gdarcnes || die "dogamesbin failed (gtk)"
	fi
	if $build_X ; then
		dogamesbin darcnes || die "dogamesbin failed"
	fi
	dodoc readme
	prepgamesdirs
}
