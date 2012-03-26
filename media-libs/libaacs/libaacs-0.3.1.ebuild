# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libaacs/libaacs-0.3.1.ebuild,v 1.1 2012/03/26 01:00:18 radhermit Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="Open implementation of the Advanced Access Content System (AACS) specification"
HOMEPAGE="http://www.videolan.org/developers/libaacs.html"
SRC_URI="ftp://ftp.videolan.org/pub/videolan/libaacs/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="examples static-libs"

RDEPEND="dev-libs/libgcrypt
	dev-libs/libgpg-error"
DEPEND="${RDEPEND}"

DOCS=( ChangeLog KEYDB.cfg README.txt )

src_configure() {
	local myeconfargs=(
		--disable-optimizations
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	if use examples ; then
		cd "${AUTOTOOLS_BUILD_DIR}"/src/examples/.libs || die
		dobin libaacs_test parser_test
	fi
}
