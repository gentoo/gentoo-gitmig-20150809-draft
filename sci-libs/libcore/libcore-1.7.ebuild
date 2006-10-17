# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libcore/libcore-1.7.ebuild,v 1.2 2006/10/17 15:16:45 djay Exp $

inherit eutils toolchain-funcs

DESCRIPTION="The main goal of the CORE project is to address the issues of
robust numerical and geometric computation."
HOMEPAGE="http://www.cs.nyu.edu/exact/core_pages/"
MYP="${PN/lib}"
SRC_URI="http://cs.nyu.edu/exact/core/download/prerelease/${MYP}_v${PV}x_std.tgz"

LICENSE="QPL-1.0"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="dev-libs/gmp
	doc? ( virtual/tetex ) "
RDEPEND="virtual/libc"

S="${WORKDIR}/${MYP}_v${PV}x"

src_unpack(){
	unpack "${A}"
	cd "${S}"
	epatch ${FILESDIR}/${P}.patch || die "Unable to patch sources"
}

src_compile(){
	cd "${S}"
	emake CXX=$(tc-getCXX) corelib || die "Unable to create corelib"
	emake CXX=$(tc-getCXX) corex || die "Unable to create corex"
	if use doc; then
		cd "${S}/doc"
		emake all || die "Unable to create doc"
	fi
}

src_install(){
	cd "${S}"
	dolib lib/*.a lib/*.so || die "Unable to find libraries"
	for i in $(find "${D}/usr/lib/" -name "*so" | sed "s:${D}::g"); do
		dosym $i $i.1 && dosym $i $i.1.0.0 || die "Unable to sym $i"
	done

	dodir /usr/include || die "Unable to create include dir"
	cp -r ./inc/* "${D}/usr/include/" || "Unable to copy headers"

	dodoc FAQs README || "Unable to install default doc"
	if use doc; then
		dodoc doc/ANNOUNCEMENT* doc/*pdf doc/papers/* || \
			die "Unable to install doc"
	fi
}
