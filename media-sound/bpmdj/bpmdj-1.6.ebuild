# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bpmdj/bpmdj-1.6.ebuild,v 1.1 2003/02/28 11:24:23 pvdabeel Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Bpmdj, software for measuring the BPM of music and mixing"
HOMEPAGE="http://bpmdj.strokemusic.org"

SRC_URI="ftp://bpmdj.strokemusic.org/bpmdj/1.6/bpmdj-1.6.source.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="x11-libs/qt*"

RDEPEND="mpg123"

src_compile() {
	cp defines.gentoo defines
	cp ${FILESDIR}/makefile makefile
	make || die
}

src_install () {
	make DESTDIR=${D} deb-install || die
}
