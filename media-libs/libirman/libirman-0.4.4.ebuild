# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libirman/libirman-0.4.4.ebuild,v 1.2 2006/09/25 11:03:23 jokey Exp $

IUSE=""
inherit eutils toolchain-funcs

DESCRIPTION="library for Irman control of Unix software"
SRC_URI="http://www.lirc.org/software/snapshots/${P}.tar.gz"
HOMEPAGE="http://www.evation.com/libirman/libirman.html"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch "${FILESDIR}/${PN}-0.4.2-PICShared.patch"
	epatch "${FILESDIR}/${P}-destdir.patch"
	epatch "${FILESDIR}/${PN}-0.4.2-format.patch"
}

src_compile() {
	tc-export CC LD AR RANLIB

	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	dodir /usr/include

	make DESTDIR="${D}" \
		LIRC_DRIVER_DEVICE="${D}/dev/lirc" \
		install || die

	dobin test_func test_io test_name
	dodoc NEWS README* TECHNICAL TODO
}
