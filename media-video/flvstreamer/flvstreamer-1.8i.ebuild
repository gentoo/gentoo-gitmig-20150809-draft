# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/flvstreamer/flvstreamer-1.8i.ebuild,v 1.4 2009/11/26 21:05:01 maekke Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Open source command-line RTMP client intended to stream audio or video flash content"
HOMEPAGE="http://savannah.nongnu.org/projects/flvstreamer/"
SRC_URI="http://ftp.cc.uoc.gr/mirrors/nongnu.org/${PN}/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S="${WORKDIR}"/${PN}

src_compile() {
	# remove _x86 string from Makefile since it works on amd64
	sed -i "s/_x86//" Makefile || die "Failed to remove _x86 string"
	for target in flvstreamer streams; do
		emake CC=$(tc-getCC) CXX=$(tc-getCXX) CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}"	\
			LDFLAGS="${LDFLAGS}" ${target}
	done
}

src_install() {
	dobin {${PN},streams} || die "dobin failed"
	dodoc README ChangeLog || die "dodoc failed"
}
