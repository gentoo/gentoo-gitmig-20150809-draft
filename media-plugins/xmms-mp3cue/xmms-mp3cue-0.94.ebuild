# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-mp3cue/xmms-mp3cue-0.94.ebuild,v 1.2 2004/03/26 22:05:55 eradicator Exp $

inherit eutils

DESCRIPTION="cue file support for XMMS"
HOMEPAGE="http://brianvictor.tripod.com/mp3cue.htm"
SRC_URI="http://brianvictor.tripod.com/XMMS-mp3cue-${PV}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="debug"

S=${WORKDIR}/XMMS-mp3cue-${PV}

RDEPEND="media-sound/xmms"

DEPEND="${RDEPEND}
	sys-apps/sed"

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
