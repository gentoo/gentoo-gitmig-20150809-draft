# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavesurfer/wavesurfer-1.7.ebuild,v 1.4 2004/10/07 03:32:13 eradicator Exp $

DESCRIPTION="tool for recording, playing, editing, viewing and labeling of audio"
HOMEPAGE="http://www.speech.kth.se/wavesurfer/"
SRC_URI="http://www.speech.kth.se/wavesurfer/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc amd64 sparc"
IUSE=""

RDEPEND=">=dev-tcltk/snack-2.2.4"

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i -e 's/wish[0-9.]\+/wish/' wavesurfer.tcl || die
}

src_install() {
	local mydir="wsurf${PV}"

	newbin wavesurfer.tcl wavesurfer
	dodir /usr/$(get_libdir)/${mydir}
	cp -r ${mydir} ${D}/usr/$(get_libdir)/

	insinto /usr/$(get_libdir)/${mydir}/plugins
	doins plugins/*.plug
	insinto /usr/$(get_libdir)/${mydir}/icons
	doins icons/*

	dodoc README.txt
	dohtml doc/*
	for mydir in demos msgs python tools
	do
		docinto ${mydir}
		dodoc ${mydir}/*
	done
}
