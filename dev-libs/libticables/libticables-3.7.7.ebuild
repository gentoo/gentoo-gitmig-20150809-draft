# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libticables/libticables-3.7.7.ebuild,v 1.4 2004/06/24 23:24:04 agriffis Exp $

DESCRIPTION="libticables is a necessary library for the TiLP calculator linking program."
HOMEPAGE="http://tilp.sourceforge.net/"

SRC_URI="mirror://sourceforge/tilp/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
# Only tested on x86 so far...
KEYWORDS="x86"
IUSE=""
DEPEND=""

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	einstall aclocaldir=${D}/usr/share/aclocal || die
}
