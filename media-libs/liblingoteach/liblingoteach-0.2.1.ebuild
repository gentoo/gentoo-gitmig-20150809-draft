# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liblingoteach/liblingoteach-0.2.1.ebuild,v 1.1 2004/12/30 05:44:54 chriswhite Exp $

inherit eutils

DESCRIPTION="A library to support lingoteach-ui and for generic lesson development."
HOMEPAGE="http://www.lingoteach.org"
SRC_URI="mirror://sourceforge/lingoteach/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE="debug zlib"
DEPEND="dev-util/pkgconfig
		zlib? ( sys-libs/zlib )"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	econf \
	$(use_enable zlib compression) \
	$(use_enable debug) \
	|| die "econf failed"

	sed -i -e "s:^HTML_DIR = :HTML_DIR = ${D}/:" -i doc/Makefile

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
