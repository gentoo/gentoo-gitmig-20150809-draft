# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lcms/lcms-1.14-r1.ebuild,v 1.18 2007/03/27 09:34:12 lucass Exp $

inherit libtool eutils autotools

DESCRIPTION="A lightweight, speed optimized color management engine"
HOMEPAGE="http://www.littlecms.com/"
SRC_URI="http://www.littlecms.com/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="tiff jpeg zlib python"

DEPEND="tiff? ( media-libs/tiff )
	jpeg? ( media-libs/jpeg )
	zlib? ( sys-libs/zlib )
	python? ( >=dev-lang/python-1.5.2 )"
RDEPEND="jpeg? ( media-libs/jpeg )
	python? ( >=dev-lang/python-1.5.2 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fixes bug #98547
	epatch "${FILESDIR}"/lcms.i.diff

	# fix build on amd64, conditional for ppc-macos because it lacks the
	# proper automake version (1.7)
	use ppc-macos || eautoreconf || die "autoreconf failed"

	elibtoolize
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_with jpeg) \
		$(use_with tiff) \
		$(use_with zlib) \
		$(use_with python) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make \
		DESTDIR="${D}" \
		BINDIR="${D}"/usr/bin \
		install || die "make install failed"

	insinto /usr/share/lcms/profiles
	doins testbed/*.icm

	dodoc AUTHORS README* INSTALL NEWS doc/*
}
