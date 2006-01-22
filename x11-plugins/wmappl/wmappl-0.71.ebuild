# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmappl/wmappl-0.71.ebuild,v 1.6 2006/01/22 13:33:36 nelchael Exp $

IUSE=""
DESCRIPTION="Simple application launcher for the Window Maker dock."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://wmappl.sourceforge.net/"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXt
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64 ppc"

src_compile() {
	econf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install () {
	einstall || die "Installation failed"
}
