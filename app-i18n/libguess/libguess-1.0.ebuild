# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/libguess/libguess-1.0.ebuild,v 1.7 2011/07/11 18:50:36 aballier Exp $

EAPI=2

DESCRIPTION="A high-speed character set detection library."
HOMEPAGE="http://www.atheme.org/project/libguess"
SRC_URI="http://distfiles.atheme.org/${P}.tbz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="examples"

RDEPEND="
	>=dev-libs/libmowgli-0.7.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0"

src_configure() {
	econf $(use_enable examples) \
		|| die "econf failed"
}

src_test() {
	cd src/tests
	make || die "test failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README
}
