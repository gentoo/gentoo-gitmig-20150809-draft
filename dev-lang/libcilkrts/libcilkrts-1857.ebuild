# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/libcilkrts/libcilkrts-1857.ebuild,v 1.1 2012/06/14 19:38:03 ottxor Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="Intel Cilk Plus run time library"
HOMEPAGE="http://software.intel.com/en-us/articles/intel-cilk-plus/"
SRC_URI="http://software.intel.com/file/38088 -> cilkplus-rtl-001857.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="static-libs"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

AUTOTOOLS_AUTORECONF=1

DOCS=( README )

PATCHES=( "${FILESDIR}/${P}-include.patch" )
