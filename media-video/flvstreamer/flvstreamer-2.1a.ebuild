# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/flvstreamer/flvstreamer-2.1a.ebuild,v 1.1 2010/01/10 18:37:25 hanno Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Open source command-line RTMP client intended to stream audio or video flash content"
HOMEPAGE="http://savannah.nongnu.org/projects/flvstreamer/"
SRC_URI="mirror://nongnu/${PN}/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
S="${WORKDIR}/${PN}"

src_prepare() {
	#fix Makefile ( bug #298535 )
	sed -i "s/\$(MAKEFLAGS)/-\$(MAKEFLAGS)/" Makefile \
		|| die "failed to fixe Makefile"
}

src_compile() {
	emake CC=$(tc-getCC) CXX=$(tc-getCXX) CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}"	\
			LDFLAGS="${LDFLAGS}" linux
}

src_install() {
	dobin {${PN},streams} || die "dobin failed"
	dodoc README ChangeLog || die "dodoc failed"
}
