# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-mp3cue/xmms-mp3cue-0.94-r1.ebuild,v 1.3 2004/09/03 08:13:36 eradicator Exp $

inherit eutils

DESCRIPTION="cue file support for XMMS"
HOMEPAGE="http://brianvictor.tripod.com/mp3cue.htm"
SRC_URI="http://brianvictor.tripod.com/XMMS-mp3cue-${PV}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 sparc"
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
	epatch ${FILESDIR}/${P}-fPIC.patch
}

src_install() {
	exeinto `xmms-config --general-plugin-dir`
	doexe libmp3cue.so

	dodoc ${DOCS}
}
