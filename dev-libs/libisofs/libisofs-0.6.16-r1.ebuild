# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libisofs/libisofs-0.6.16-r1.ebuild,v 1.1 2009/04/27 12:46:44 loki_val Exp $

EAPI=2

DESCRIPTION="libisofs is an open-source library for reading, mastering and writing optical discs."
HOMEPAGE="http://libburnia-project.org/"
SRC_URI="http://files.libburnia-project.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? ( >=dev-util/cunit-2.1 )"

src_configure() {
	econf --disable-static
}

src_test() {
	emake check || die "building tests failed"
	test/test || die "running tests failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README NEWS Roadmap TODO
	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}
