# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/atomicparsley/atomicparsley-0.9.0.ebuild,v 1.12 2009/07/21 21:55:46 ssuominen Exp $

EAPI=2
MY_P=AtomicParsley-source-${PV}
inherit eutils toolchain-funcs

DESCRIPTION="command line program for reading, parsing and setting iTunes-style metadata in MPEG4 files"
HOMEPAGE="http://atomicparsley.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 sparc x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip
	sys-apps/sed"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-glibc-2.10.patch
	sed -i -e "s:g++:$(tc-getCXX):g" build || die "sed failed"
}

src_compile() {
	./build || die "build failed"
}

src_install() {
	dobin AtomicParsley || die "dobin failed"
	dodoc *.{txt,rtf}
}
