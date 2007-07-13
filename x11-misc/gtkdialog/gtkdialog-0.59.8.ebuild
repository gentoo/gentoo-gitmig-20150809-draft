# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gtkdialog/gtkdialog-0.59.8.ebuild,v 1.9 2007/07/13 05:09:41 mr_bones_ Exp $

inherit eutils

DESCRIPTION="GUI-creation utility that can be used with an arbitrary interpreter"
HOMEPAGE="http://linux.pte.hu/~pipas/gtkdialog/"
SRC_URI="ftp://linux.pte.hu/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {

	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-amd64.patch"

}

src_install(){

	einstall || die "einstall failed"
	dodoc AUTHORS ChangeLog NEWS README TODO

	if use doc; then
		mkdir -p "${D}/usr/share/${P}"
		cp -r examples/* "${D}/usr/share/${P}"
	fi

}
