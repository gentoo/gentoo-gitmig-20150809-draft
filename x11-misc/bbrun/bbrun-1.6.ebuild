# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbrun/bbrun-1.6.ebuild,v 1.6 2006/12/04 01:22:16 omp Exp $

DESCRIPTION="blackbox program execution dialog box"
HOMEPAGE="http://www.darkops.net/bbrun/"
SRC_URI="http://www.darkops.net/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}/bbrun"
	sed -i "s:-g -c -O2:-c ${CFLAGS}:" Makefile || die "sed Makefile failed"
}

src_compile() {
	cd "${S}/bbrun"
	emake || die "emake failed"
}

src_install () {
	dobin bbrun/bbrun || die "failed to install bbrun"
	dodoc Changelog README
}
