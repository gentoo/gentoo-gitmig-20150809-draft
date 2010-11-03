# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libcmatrix/libcmatrix-3.2.1.ebuild,v 1.2 2010/11/03 09:35:06 jlec Exp $

EAPI="3"

inherit autotools eutils

MY_P="${PN}${PV}_lite"

DESCRIPTION="lite version of pNMRsim"
HOMEPAGE="http://www.dur.ac.uk/paul.hodgkinson/pNMRsim/"
#SRC_URI="${HOMEPAGE}/${MY_P}.tar.gz"
SRC_URI="http://dev.gentooexperimental.org/~jlec/distfiles/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="atlas threads"

RDEPEND="
	sci-libs/minuit
	atlas? ( sci-libs/blas-atlas )"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${PN}R3

src_prepare() {
	epatch \
		"${FILESDIR}"/${PV}-shared.patch \
		"${FILESDIR}"/${PV}-minuit2.patch \
		"${FILESDIR}"/${PV}-gcc4.4.patch
	eautoreconf
}

src_configure() {
	econf \
		--with-minuit \
		$(use_with atlas) \
		$(use_with threads)
}

src_install() {
	dolib.so lib/*.so* || die "install failed"

	insinto /usr/include/${PN}R3
	doins include/* || die "no includes"

	dodoc CHANGES docs/* || die "no docs"
}
