# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libffi/libffi-3.0.6.ebuild,v 1.1 2008/09/02 15:08:51 hkbst Exp $

inherit eutils

DESCRIPTION="a portable, high level programming interface to various calling conventions."
HOMEPAGE="http://sourceware.org/libffi"
SRC_URI="ftp://sourceware.org/pub/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug test"

DEPEND="test? ( dev-util/dejagnu )"
RDEPEND=""

pkg_setup() {
	ewarn "This package provides a separate libffi which may conflict with the"
	ewarn "one provided by sys-devel/gcc when it is built with libffi use flag on."
	ebeep
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
