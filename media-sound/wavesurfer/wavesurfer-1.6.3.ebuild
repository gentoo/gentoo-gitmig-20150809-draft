# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavesurfer/wavesurfer-1.6.3.ebuild,v 1.2 2004/04/25 16:03:32 dholm Exp $

DESCRIPTION="tool for recording, playing, editing, viewing and labling of audio"
HOMEPAGE="http://www.speech.kth.se/wavesurfer/"
SRC_URI="http://www.speech.kth.se/wavesurfer/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=">=dev-tcltk/snack-2.2.4"

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i -e 's/wish[0-9.]\+/wish/' wavesurfer.tcl || die
}

src_install() {
	local mydir="wsurf${PV%.*}"

	newbin wavesurfer.tcl wavesurfer
	dodir /usr/lib/${mydir}
	cp -r ${mydir} ${D}/usr/lib/

	insinto /usr/lib/${mydir}/plugins
	doins plugins/*.plug
	insinto /usr/lib/${mydir}/icons
	doins icons/*

	dodoc README.txt
	dohtml doc/*
	for mydir in demos msgs python tools
	do
		docinto ${mydir}
		dodoc ${mydir}/*
	done
}
