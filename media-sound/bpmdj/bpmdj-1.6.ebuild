# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bpmdj/bpmdj-1.6.ebuild,v 1.5 2004/03/19 23:32:16 eradicator Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Bpmdj, software for measuring the BPM of music and mixing"
HOMEPAGE="http://bpmdj.strokemusic.org"

SRC_URI="ftp://progpc26.vub.ac.be/pub/bpmdj/1.6/bpmdj-1.6.source.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="x11-libs/qt*
	virtual/tetex"

RDEPEND="virtual/mpg123"

src_compile() {
	cp defines.gentoo defines
	make VARTEXFONTS=${T}/fonts || die
}

src_install () {
	make DESTDIR=${D} deb-install || die
	mv ${D}/usr/share/doc/{${PN},${PF}}
}
