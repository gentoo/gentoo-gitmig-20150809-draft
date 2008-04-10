# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/atomicparsley/atomicparsley-0.9.0.ebuild,v 1.11 2008/04/10 07:49:58 drac Exp $

inherit toolchain-funcs

MY_P=AtomicParsley-source-${PV}

DESCRIPTION="command line program for reading, parsing and setting iTunes-style metadata in MPEG4 files"
HOMEPAGE="http://atomicparsley.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 sparc x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	sed -i -e "s:g++:$(tc-getCXX):g" "${S}"/build || die "sed failed."
}

src_compile() {
	./build || die "build failed."
}

src_install() {
	dobin AtomicParsley || die "dobin failed."
	dodoc *.{txt,rtf}
}
