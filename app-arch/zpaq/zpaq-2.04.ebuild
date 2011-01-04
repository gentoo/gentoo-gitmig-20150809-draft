# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/zpaq/zpaq-2.04.ebuild,v 1.1 2011/01/04 23:19:48 mgorny Exp $

EAPI=3

inherit autotools autotools-utils

LIB_PV=202
PROG_PV=${PV/./}

DESCRIPTION="A unified compressor for PAQ algorithms"
HOMEPAGE="http://mattmahoney.net/dc/zpaq.html"
SRC_URI="http://mattmahoney.net/dc/${PN}.${PROG_PV}.zip
	http://mattmahoney.net/dc/lib${PN}.${LIB_PV}.zip"

LICENSE="GPL-3 ISOC-rfc"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}

DOCS=( libzpaq.txt )

src_prepare() {
	EPATCH_OPTS+=-p1 epatch "${FILESDIR}"/0001-Add-autotools-files.patch
	autotools-utils_src_prepare
	eautoreconf
}

pkg_postinst() {
	elog "You may also want to install app-arch/zpaq-extras package which provides"
	elog "few additional configs and preprocessors for use with zpaq."
}
