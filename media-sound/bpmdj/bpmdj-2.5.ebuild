# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bpmdj/bpmdj-2.5.ebuild,v 1.1 2004/07/21 00:14:45 eradicator Exp $

DESCRIPTION="Bpmdj, software for measuring the BPM of music and mixing"
HOMEPAGE="http://bpmdj.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.source.tgz"

LICENSE="GPL-2"
SLOT="0"
#-amd64: 2.5: kbpm-play: common.cpp:64: void common_init(): Assertion `sizeof(signed4)==4'
KEYWORDS="~x86 -amd64"

IUSE=""

DEPEND="x11-libs/qt
	virtual/tetex"

RDEPEND="${DEPEND}
	 media-sound/alsamixergui
	 virtual/mpg123"

src_compile() {
	addwrite "${QTDIR}/etc/settings"

	cp defines.gentoo defines
	make ${MAKEOPTS} CPP=g++ CC=gcc VARTEXFONTS=${T}/fonts || die
}

src_install () {
#	broken in 2.5
#	make DESTDIR="${D}" install || die
#	mv ${D}/usr/share/doc/{${PN},${PF}}

	exeinto /usr/bin
	doexe kbpm-play kbpm-dj merger bpmdj-raw rbpm-play xmms-play alsamixerguis bpmdj-replay bpmdj-record record_mixer bpmdj-import-mp3.pl bpmdj-import-ogg.pl || die
}
