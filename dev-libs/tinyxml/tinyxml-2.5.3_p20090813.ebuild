# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tinyxml/tinyxml-2.5.3_p20090813.ebuild,v 1.1 2009/08/13 02:26:57 ssuominen Exp $

EAPI="2"

DESCRIPTION="a simple, small, C++ XML parser that can be easily integrating into other programs"
HOMEPAGE="http://www.grinninglizard.com/tinyxml/index.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug doc"

RDEPEND=""
DEPEND="dev-util/scons
	doc? ( app-doc/doxygen )"

src_prepare() {
	sed -i -e 's:-O3::' SConstruct || die "sed failed"
}

src_compile() {
	local debug=0
	use debug && debug=1

	scons debug=${debug} program=0 sharedlibrary=1 staticlibrary=1 \
		. || die "scons failed"
	
	if use doc; then
		doxygen dox || die "doxygen failed"
	fi
}

src_install() {
	dolib.so *.so || die "dolib.so failed"
	dolib.a *.a || die "dolib.a failed"

	insinto /usr/include
	doins *.h || die "doins failed"

	dodoc {changes,readme}.txt || die "dodoc failed"

	if use doc; then
		dodoc tutorial_gettingStarted.txt || die "dodoc failed"
		dohtml -r docs/* || die "dohtml failed"
	fi
}
