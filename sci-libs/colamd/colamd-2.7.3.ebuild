# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/colamd/colamd-2.7.3.ebuild,v 1.7 2011/12/26 12:33:25 maekke Exp $

EAPI=4

inherit autotools-utils eutils

MY_PN=COLAMD
DESCRIPTION="Column approximate minimum degree ordering algorithm"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/colamd/"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="static-libs"

DEPEND="sci-libs/ufconfig"
RDEPEND="${DEPEND}"

# Needs manual inspection of the result, useless.
RESTRICT="test"

DOCS=( README.txt Doc/ChangeLog )

S="${WORKDIR}/${MY_PN}"

AUTOTOOLS_IN_SOURCE_BUILD=1

PATCHES=(
	"${FILESDIR}"/${PN}-2.7.1-autotools.patch
)

src_prepare() {
	autotools-utils_src_prepare
	eautoreconf
}
