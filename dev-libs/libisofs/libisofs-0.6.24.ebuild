# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libisofs/libisofs-0.6.24.ebuild,v 1.2 2009/11/24 19:59:09 klausman Exp $

EAPI=2

DESCRIPTION="libisofs is an open-source library for reading, mastering and writing optical discs."
HOMEPAGE="http://libburnia-project.org/"
SRC_URI="http://files.libburnia-project.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="acl xattr zlib"
#IUSE="test"

# http://libburnia-project.org/ticket/147#comment:4
# Currently the tests are outdated. The time needed to repair the problematic code
# in test_rockridge.c would be better invested in re-arranging the test suit
# around the official libisofs API. Everybody seems busy with other things,
# though.
#
# So it is best to disable test/test until its fate is decided.
RESTRICT="test"

RDEPEND="acl? ( virtual/acl )
	xattr? ( sys-apps/attr )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
#	test? ( >=dev-util/cunit-2.1 )"

src_configure() {
	econf --disable-static \
	$(use_enable acl libacl) \
	$(use_enable xattr) \
	$(use_enable zlib)
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
