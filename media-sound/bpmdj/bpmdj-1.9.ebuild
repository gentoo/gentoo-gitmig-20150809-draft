# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bpmdj/bpmdj-1.9.ebuild,v 1.2 2003/08/21 12:23:18 usata Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Bpmdj, software for measuring the BPM of music and mixing"
HOMEPAGE="http://bpmdj.strokemusic.org"

SRC_URI="ftp://progpc26.vub.ac.be/pub/bpmdj/1.9/bpmdj-1.9.source.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"

DEPEND="x11-libs/qt*
	virtual/tetex"
RDEPEND="mpg123"

inherit eutils

src_compile() { 
	make VARTEXFONTS=${T}/fonts || die
}

src_install () {
	make DESTDIR=${D} deb-install || die
	mv ${D}/usr/share/doc/{${PN},${PF}}
}
