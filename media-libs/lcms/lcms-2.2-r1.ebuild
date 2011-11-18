# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lcms/lcms-2.2-r1.ebuild,v 1.5 2011/11/18 15:57:25 chainsaw Exp $

EAPI=4
inherit eutils

DESCRIPTION="A lightweight, speed optimized color management engine"
HOMEPAGE="http://www.littlecms.com/"
SRC_URI="mirror://sourceforge/${PN}/lcms2-${PV}.tar.gz"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="doc jpeg static-libs test tiff zlib"

RDEPEND="jpeg? ( virtual/jpeg )
	tiff? ( media-libs/tiff:0 )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/lcms2-${PV}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-header.patch \
		"${FILESDIR}"/${P}-lm.patch \
		"${FILESDIR}"/${P}-fix-test-on-sparc.patch
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_with jpeg) \
		$(use_with tiff) \
		$(use_with zlib)
}

src_compile() {
	default

	if use test; then
		cd testbed
		emake testcms
	fi
}

src_test() {
	cd testbed
	./testcms || die
}

src_install() {
	default

	if use doc; then
		docinto pdf
		dodoc doc/*.pdf
	fi

	find "${ED}" -name '*.la' -exec rm -f {} +
}
