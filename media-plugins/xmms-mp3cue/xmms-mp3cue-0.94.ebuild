# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-mp3cue/xmms-mp3cue-0.94.ebuild,v 1.1 2004/02/12 11:47:42 eradicator Exp $

DESCRIPTION="cue file support for XMMS"
HOMEPAGE="http://brianvictor.tripod.com/mp3cue.htm"
SRC_URI="http://brianvictor.tripod.com/XMMS-mp3cue-${PV}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="debug"

S=${WORKDIR}/XMMS-mp3cue-${PV}

DEPEND=">=media-sound/xmms-1.2.7-r20
	sys-apps/sed"

RDEPEND=">=media-sound/xmms-1.2.7-r20"

DOCS="Changelog INSTALL README TODO"

src_unpack() {
	unpack ${A}

	cd ${S};

	if use debug; then
		sed -i 's/DEBUG := n/DEBUG := y/g' Makefile.in
	fi

	epatch ${FILESDIR}/${P}-import-cue-bug.patch
}

src_install() {
	exeinto `xmms-config --general-plugin-dir`
	doexe libmp3cue.so

	dodoc ${DOCS}
}
