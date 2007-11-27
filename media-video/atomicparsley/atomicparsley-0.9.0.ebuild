# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/atomicparsley/atomicparsley-0.9.0.ebuild,v 1.9 2007/11/27 12:20:38 zzam Exp $

DESCRIPTION="command line program for reading, parsing and setting iTunes-style metadata in MPEG4 files"
HOMEPAGE="http://atomicparsley.sourceforge.net"

my_P="AtomicParsley-source-${PV}"

SRC_URI="mirror://sourceforge/${PN}/${my_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 sparc x86"
IUSE=""
DEPEND=""

src_compile() {
	cd "${WORKDIR}/${my_P}"
	./build
}

src_install() {
	cd "${WORKDIR}/${my_P}"

	exeinto /usr/bin
	doexe AtomicParsley
	dodoc "Using AtomicParsley.rtf" "AP buglist.txt" COPYING
}
