# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/flvstreamer/flvstreamer-1.9.ebuild,v 1.1 2009/12/15 20:19:01 hwoarang Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Open source command-line RTMP client intended to stream audio or video flash content"
HOMEPAGE="http://savannah.nongnu.org/projects/flvstreamer/"
SRC_URI="http://ftp.cc.uoc.gr/mirrors/nongnu.org/${PN}/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	emake CC=$(tc-getCC) CXX=$(tc-getCXX) CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}"	\
			LDFLAGS="${LDFLAGS}" linux
}

src_install() {
	dobin {${PN},streams} || die "dobin failed"
	dodoc README ChangeLog || die "dodoc failed"
}
