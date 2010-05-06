# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/flvstreamer/flvstreamer-2.1a.ebuild,v 1.2 2010/05/06 11:16:06 hwoarang Exp $

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
	#fix Makefile ( bug #298535 and bug #318353)
	sed -i 's/\$(MAKEFLAGS)//g' Makefile \
		|| die "failed to fixe Makefile"
}

src_compile() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}"	\
			LDFLAGS="${LDFLAGS}" linux
}

src_install() {
	dobin {${PN},streams} || die "dobin failed"
	dodoc README ChangeLog || die "dodoc failed"
}
