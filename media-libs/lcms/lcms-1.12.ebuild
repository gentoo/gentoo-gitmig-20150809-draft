# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lcms/lcms-1.12.ebuild,v 1.4 2004/01/25 22:00:43 gustavoz Exp $

DESCRIPTION="A lightweight, speed optimized color management engine"
HOMEPAGE="http://www.littlecms.com/"
SRC_URI="http://www.littlecms.com/${P}.tar.gz"

KEYWORDS="x86 ~ppc sparc ~alpha hppa ~amd64 ~ia64"
LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="tiff? ( media-libs/tiff )
	jpeg? ( media-libs/jpeg )
	zlib? ( sys-libs/zlib )
	python? ( >=dev-lang/python-1.5.2 )"

IUSE="tiff jpeg zlib python"

src_compile() {
	econf \
		--disable-dependency-tracking \
		`use_with jpeg` \
		`use_with tiff` \
		`use_with zlib` \
		`use_with python` || die
	emake || die "emake failed"
}

src_install() {
	make \
		DESTDIR=${D} \
		BINDIR=${D}/usr/bin \
		includedir="/usr/include/${PN}" \
		install                              || die "make install failed"

	insinto /usr/share/lcms/profiles
	doins testbed/*.icm

	dodoc AUTHORS README* INSTALL NEWS doc/*
}
