# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fwcrv/fwcrv-0.1.0.ebuild,v 1.1 2005/01/09 10:22:40 robbat2 Exp $

inherit eutils

DESCRIPTION="FireWire CSR Config ROM Viewer"
HOMEPAGE="http://www.hugovil.com/en/fwcrv/"
SRC_URI="http://www.hugovil.com/repository/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="sys-libs/libraw1394"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS README src/testdata.txt TODO
}

