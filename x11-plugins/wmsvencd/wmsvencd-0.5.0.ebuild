# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmsvencd/wmsvencd-0.5.0.ebuild,v 1.10 2011/05/26 13:07:49 s4t4n Exp $

inherit eutils

IUSE=""

DESCRIPTION="Window Maker Dockable CD-Player with CDDB"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="file:///dev/null"

DEPEND="x11-wm/windowmaker
	x11-libs/libXpm"

RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

src_unpack() {

	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/wmsvencd-compile.patch

	sed -i 's:c++ -o:c++ $(LDFLAGS) -o:' Makefile
}

src_compile() {

	emake CFLAGS="${CFLAGS} -fno-strength-reduce" || die "make failed"

}

src_install() {

	newman wmsvencd.1x wmsvencd.1
	dobin wmsvencd
	dodoc README

	insinto /usr/share/applications
	doins "${FILESDIR}"/${PN}.desktop
}
