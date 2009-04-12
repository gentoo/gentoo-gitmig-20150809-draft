# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/physfs/physfs-1.0.2.ebuild,v 1.1 2009/04/12 16:33:55 mr_bones_ Exp $

EAPI=2
DESCRIPTION="abstraction layer for filesystems, useful for games"
HOMEPAGE="http://icculus.org/physfs/"
SRC_URI="http://icculus.org/physfs/downloads/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="sys-libs/zlib"

src_configure() {
	# the test prog is not used by src_test() or installed,
	# so lets just punt it and be done
	econf \
		--disable-dependency-tracking \
		--disable-testprog \
		--disable-internal-zlib
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rmdir "${D}"/usr/bin
	dodoc CHANGELOG CREDITS TODO docs/README
}
