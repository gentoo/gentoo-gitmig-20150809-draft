# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libffi/libffi-3.0.8.ebuild,v 1.19 2009/10/02 19:53:34 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="a portable, high level programming interface to various calling conventions."
HOMEPAGE="http://sourceware.org/libffi"
SRC_URI="ftp://sourceware.org/pub/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="debug static-libs test"

RDEPEND=""
DEPEND="!<dev-libs/g-wrap-1.9.11
	test? ( dev-util/dejagnu )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-fbsd.patch \
		"${FILESDIR}"/${P}-autoconf-2.64.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog* README TODO
}

pkg_postinst() {
	if has_version sys-devel/gcc[libffi]; then
		ewarn "Please unset USE flag libffi in sys-devel/gcc. There is no"
		ewarn "file collision but your package might link to wrong library."
		ebeep
	fi
}
