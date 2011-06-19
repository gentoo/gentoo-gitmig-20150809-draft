# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/clapack/clapack-3.2.1-r6.ebuild,v 1.1 2011/06/19 20:35:56 dilfridge Exp $

EAPI=4

inherit base cmake-utils

DESCRIPTION="f2c'ed version of LAPACK"
HOMEPAGE="http://www.netlib.org/clapack/"
SRC_URI="http://www.netlib.org/${PN}/${P}-CMAKE.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

RDEPEND=">=dev-libs/libf2c-20090407-r1
	virtual/blas"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}-CMAKE

PATCHES=(
	"${FILESDIR}/${P}-fix_include_file.patch"
	"${FILESDIR}/${P}-noblasf2c.patch"
	"${FILESDIR}/${P}-hang.patch"
	"${FILESDIR}/${P}-findblas-r6.patch"
)

src_configure() {
	local mycmakeargs=( $(cmake-utils_use_enable test TESTS) )
	cmake-utils_src_configure
}
