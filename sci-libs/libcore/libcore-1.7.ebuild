# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libcore/libcore-1.7.ebuild,v 1.5 2009/02/02 23:01:37 bicatali Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Robust numerical and geometric computation library"
HOMEPAGE="http://www.cs.nyu.edu/exact/core_pages/"
MYP="${PN/lib}"
SRC_URI="http://cs.nyu.edu/exact/core/download/prerelease/${MYP}_v${PV}x_std.tgz"

LICENSE="QPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-libs/gmp
	doc? ( virtual/latex-base ) "
RDEPEND=""

S="${WORKDIR}/${MYP}_v${PV}x"

src_unpack(){
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}.patch
	sed -i \
		-e "s/-O2/${CXXFLAGS}/g" \
		-e "s/-shared/-shared ${LDFLAGS}/g" \
		Make.config || die
}

src_compile(){
	emake CXX="$(tc-getCXX)" corelib || die "Unable to create corelib"
	emake CXX="$(tc-getCXX)" corex || die "Unable to create corex"
	if use doc; then
		cd "${S}/doc"
		emake all || die "Unable to create doc"
	fi
}

src_install(){
	dolib lib/*.a lib/*.so || die "Unable to find libraries"
	for i in $(find "${D}/usr/lib/" -name "*so" | sed "s:${D}::g"); do
		dosym $i $i.1 && dosym $i $i.1.0.0 || die "Unable to sym $i"
	done

	dodir /usr/include || die "Unable to create include dir"
	cp -r ./inc/* "${D}/usr/include/" || die "Unable to copy headers"

	dodoc FAQs README || die "Unable to install default doc"
	if use doc; then
		dodoc doc/ANNOUNCEMENT* doc/*pdf doc/papers/* || \
			die "Unable to install doc"
	fi
}
