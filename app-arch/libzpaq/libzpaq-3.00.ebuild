# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/libzpaq/libzpaq-3.00.ebuild,v 1.1 2011/08/25 10:24:35 mgorny Exp $

EAPI=3

inherit autotools autotools-utils

MY_P=${PN}${PV/./}
DESCRIPTION="Library to compress files or objects in the ZPAQ format"
HOMEPAGE="http://mattmahoney.net/dc/zpaq.html"
SRC_URI="http://mattmahoney.net/dc/${MY_P}.zip"

LICENSE="zpaq"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}

src_prepare() {
	EPATCH_OPTS+=-p1 epatch "${FILESDIR}"/0001-Add-autotools-files.patch
	autotools-utils_src_prepare
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--with-library-version=1:0:0
	)

	autotools-utils_src_configure
}
