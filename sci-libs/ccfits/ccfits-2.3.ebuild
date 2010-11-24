# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/ccfits/ccfits-2.3.ebuild,v 1.1 2010/11/24 20:11:54 bicatali Exp $

EAPI=2
inherit eutils autotools

MYPN=CCfits
MYP=${MYPN}-${PV}

DESCRIPTION="C++ interface for cfitsio"
HOMEPAGE="http://heasarc.gsfc.nasa.gov/fitsio/CCfits/"
SRC_URI="${HOMEPAGE}/${MYP}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=sci-libs/cfitsio-3.080"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MYPN}"

src_prepare() {
	# avoid building cookbook by default and no rpath
	epatch "${FILESDIR}"/${PN}-2.2-makefile.patch
	AT_M4DIR=config/m4 eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGES
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins *.pdf || die
		doins -r html || die
	fi
}
