# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/exempi/exempi-2.0.2.ebuild,v 1.15 2009/04/27 14:07:36 jer Exp $

inherit autotools eutils

DESCRIPTION="Exempi is a port of the Adobe XMP SDK to work on UNIX"
HOMEPAGE="http://libopenraw.freedesktop.org/wiki/Exempi"
SRC_URI="http://libopenraw.freedesktop.org/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE="examples test"

RDEPEND="dev-libs/expat
	virtual/libiconv"
DEPEND="${RDEPEND}
	test? ( >=dev-libs/boost-1.33.0 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# don't waste time on autoreconf for those who don't want to run unit tests
	if use test; then
		epatch "${FILESDIR}/${PN}-1.99.9-boost.m4.BOOST_FIND_LIB.patch"
		eautoreconf
	fi
}

src_compile() {
	econf $(use_enable test unittest)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS ChangeLog NEWS README

	if use examples ; then
		cd samples/source
		emake distclean
		cd "${S}"
		rm samples/Makefile* samples/source/Makefile* \
			samples/BlueSquares/Makefile*
		insinto "/usr/share/doc/${PF}"
		doins -r samples
	fi
}
