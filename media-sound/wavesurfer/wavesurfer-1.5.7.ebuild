# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavesurfer/wavesurfer-1.5.7.ebuild,v 1.3 2004/06/25 00:29:07 agriffis Exp $

DESCRIPTION="tool for recording, playing, editing, viewing and labling of audio"
HOMEPAGE="http://www.speech.kth.se/wavesurfer/"
SRC_URI="http://www.speech.kth.se/wavesurfer/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-tcltk/snack-2.2.2
	>=dev-lang/tk-8.4"

TCLV=8.4

src_unpack() {
	unpack ${A}

	cd ${S}
	cp wavesurfer.tcl ${T}
	sed -e 's/wish[0-9.]\+/wish/' ${T}/wavesurfer.tcl > wavesurfer.tcl
}

src_install() {
	newbin wavesurfer.tcl wavesurfer

	dodir /usr/lib/tcl${TCLV}/${PN}
	cp -r wsurf${PV%.*}/* demos/* icons/* ${D}usr/lib/tcl${TCLV}/${PN}
	dodoc README.txt
	dohtml doc/*
}

