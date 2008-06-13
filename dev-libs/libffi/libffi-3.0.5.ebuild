# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libffi/libffi-3.0.5.ebuild,v 1.4 2008/06/13 21:52:49 drac Exp $

inherit autotools eutils

DESCRIPTION="a portable, high level programming interface to various calling conventions."
HOMEPAGE="http://sourceware.org/libffi"
SRC_URI="ftp://sourceware.org/pub/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug test"

DEPEND="test? ( dev-util/dejagnu )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-includedir.patch
	eautoreconf
}

src_compile() {
	econf --disable-dependency-tracking \
		$(use_enable debug) || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog* README TODO
}

pkg_postinst() {
	elog "This package replaces USE libffi from sys-devel/gcc, please unset it."
}
