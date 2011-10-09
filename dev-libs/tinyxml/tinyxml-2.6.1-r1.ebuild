# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tinyxml/tinyxml-2.6.1-r1.ebuild,v 1.3 2011/10/09 16:43:36 maekke Exp $

EAPI=2
inherit flag-o-matic toolchain-funcs

DESCRIPTION="a simple, small, C++ XML parser that can be easily integrating into other programs"
HOMEPAGE="http://www.grinninglizard.com/tinyxml/index.html"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV//./_}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~sparc x86"
IUSE="debug doc stl"

RDEPEND=""
DEPEND="doc? ( app-doc/doxygen )"

S="${WORKDIR}/${PN}"

src_prepare() {
	local major_v minor_v
	major_v=$(echo ${PV} | cut -d \. -f 1)
	minor_v=$(echo ${PV} | cut -d \. -f 2-3)

	sed -e "s:@MAJOR_V@:$major_v:" \
	    -e "s:@MINOR_V@:$minor_v:" \
		"${FILESDIR}"/Makefile-2 > Makefile || die

	epatch "${FILESDIR}"/${P}-entity.patch
}

src_compile() {
	use debug && append-cppflags -DDEBUG
	use stl && append-cppflags -DTIXML_USE_STL

	tc-export AR CXX RANLIB

	emake || die "emake failed"
}

src_install() {
	dolib.so *.so* || die "dolib.so failed"
	dolib.a *.a || die "dolib.a failed"

	insinto /usr/include
	doins *.h || die "doins failed"

	dodoc {changes,readme}.txt || die "dodoc failed"

	if use doc; then
		dohtml -r docs/* || die "dohtml failed"
	fi
}
