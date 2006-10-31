# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fbpager/fbpager-0.1.4.ebuild,v 1.9 2006/10/31 05:42:58 omp Exp $

inherit eutils

DESCRIPTION="A Pager for fluxbox"
HOMEPAGE="http://fluxbox.sourceforge.net/fbpager"
SRC_URI="http://fluxbox.org/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ~sparc ~mips ~amd64 ppc"
IUSE=""

RDEPEND="x11-libs/libXrender
	x11-libs/libSM"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc41.patch"
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS NEWS README TODO
}

pkg_postinst() {
	einfo
	einfo "To run fbpager inside the FluxBox slit, use fbpager -w"
	einfo
}
