# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/clapack/clapack-3.2.1-r3.ebuild,v 1.4 2010/09/18 22:44:41 dilfridge Exp $

EAPI="3"

inherit eutils cmake-utils

DESCRIPTION="f2c'ed version of LAPACK"
HOMEPAGE="http://www.netlib.org/clapack/"
SRC_URI="http://www.netlib.org/${PN}/${P}-CMAKE.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-libs/libf2c-20090407-r1
	virtual/blas"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}-CMAKE

src_prepare() {
	epatch "${FILESDIR}"/${P}-noblasf2c.patch
	rm -rf INCLUDE/f2c.h F2CLIBS || die
}

src_configure() {
	local mycmakeargs=( $(cmake-utils_use_enable test TESTS) )
	cmake-utils_src_configure
}
