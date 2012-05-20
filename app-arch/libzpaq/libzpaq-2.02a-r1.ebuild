# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/libzpaq/libzpaq-2.02a-r1.ebuild,v 1.2 2012/05/20 10:55:32 vapier Exp $

EAPI=3

AUTOTOOLS_AUTORECONF=1
inherit autotools-utils

MY_P=${PN}.${PV/./}
DESCRIPTION="Library to compress files or objects in the ZPAQ format"
HOMEPAGE="http://mattmahoney.net/dc/zpaq.html"
SRC_URI="http://mattmahoney.net/dc/${MY_P}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

DEPEND="app-arch/unzip"
RDEPEND="!=app-arch/zpaq-2.04"

S=${WORKDIR}

src_prepare() {
	EPATCH_OPTS+=-p1 epatch "${FILESDIR}"/0001-Add-autotools-files.patch
	# XXX: update the patch instead when the old version is gone
	touch libzpaqo.cpp || die
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--with-library-version=0:0:0
	)

	autotools-utils_src_configure
}
