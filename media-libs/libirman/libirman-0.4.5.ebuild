# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libirman/libirman-0.4.5.ebuild,v 1.1 2012/05/06 16:15:36 pacho Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="library for Irman control of Unix software"
SRC_URI="http://www.lirc.org/software/snapshots/${P}.tar.bz2"
HOMEPAGE="http://www.lirc.org/software/snapshots/"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

pkg_setup() {
	tc-export CC LD AR RANLIB
}

src_configure() {
	econf --disable-static
}

src_install() {
	dodir /usr/include

	emake DESTDIR="${D}" LIRC_DRIVER_DEVICE="${D}/dev/lirc" install

	dobin test_func test_io test_name
	dodoc NEWS README* TECHNICAL TODO

	find "${D}" -name '*.la' -exec rm -f {} + || die "la file removal failed"
}
