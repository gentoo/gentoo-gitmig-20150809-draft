# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbrun/bbrun-1.6.ebuild,v 1.5 2005/03/17 08:35:26 hansmi Exp $

DESCRIPTION="blackbox program execution dialog box"
SRC_URI="http://www.darkops.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.darkops.net/bbrun/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86 ppc sparc"
IUSE=""

DEPEND=">=x11-libs/gtk+-2"

src_unpack() {
	unpack ${A}
	cd ${S}/bbrun
	sed -i "s:-g -c -O2:-c ${CFLAGS}:" Makefile || die "sed Makefile failed"
}

src_compile() {
	cd ${S}/bbrun
	emake || die "emake failed"
}

src_install () {
	dobin bbrun/bbrun || die "failed to install bbrun"
	dodoc Changelog README COPYING
}
