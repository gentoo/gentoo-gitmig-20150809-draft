# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lcms/lcms-1.13.ebuild,v 1.11 2005/03/25 10:12:33 hardave Exp $

inherit libtool gnuconfig

DESCRIPTION="A lightweight, speed optimized color management engine"
HOMEPAGE="http://www.littlecms.com/"
SRC_URI="http://www.littlecms.com/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ~ppc ppc64 ~ppc-macos sparc x86"
IUSE="tiff jpeg zlib python"

DEPEND="tiff? ( media-libs/tiff )
	jpeg? ( media-libs/jpeg )
	zlib? ( sys-libs/zlib )
	python? ( >=dev-lang/python-1.5.2 )"
RDEPEND="jpeg? ( media-libs/jpeg )
	python? ( >=dev-lang/python-1.5.2 )"

src_unpack() {
	unpack ${A}

	# an updated config.sub for the uclibc env
	gnuconfig_update || die
	elibtoolize  || die "elibtoolize failed"

	# fix build on amd64
	cd ${S}
	einfo "Running autoreconf..."
	use ppc-macos || autoreconf
	einfo "Running libtoolize..."
	elibtoolize
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		--includedir="/usr/include/${PN}" \
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
		install || die "make install failed"

	insinto /usr/share/lcms/profiles
	doins testbed/*.icm

	dodoc AUTHORS README* INSTALL NEWS doc/*
}
