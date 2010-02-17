# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/exempi/exempi-2.1.1.ebuild,v 1.3 2010/02/17 08:47:01 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Exempi is a port of the Adobe XMP SDK to work on UNIX"
HOMEPAGE="http://libopenraw.freedesktop.org/wiki/Exempi"
SRC_URI="http://libopenraw.freedesktop.org/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="examples test"

RDEPEND="dev-libs/expat
	virtual/libiconv
	sys-libs/zlib"
DEPEND="${RDEPEND}
	test? ( >=dev-libs/boost-1.37 )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.99.9-boost.m4.BOOST_FIND_LIB.patch \
		"${FILESDIR}"/${P}-iconv.patch
	touch config.rpath
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable test unittest)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO || die

	if use examples; then
		emake -C samples/source distclean
		rm -f samples/{,source,testfiles}/Makefile*
		insinto /usr/share/doc/${PF}/examples
		doins -r samples/* || die
	fi
}
