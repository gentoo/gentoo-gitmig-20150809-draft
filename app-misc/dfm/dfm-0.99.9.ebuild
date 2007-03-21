# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dfm/dfm-0.99.9.ebuild,v 1.13 2007/03/21 20:48:31 armin76 Exp $

DESCRIPTION="Desktop Manager. Good replacement for gmc or nautilus"
SRC_URI="http://www.kaisersite.de/dfm/${P}.tar.gz"
HOMEPAGE="http://www.kaisersite.de/dfm/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	=media-libs/imlib-1.9*
	x11-libs/libXpm"

S=${WORKDIR}/${PN}

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	einstall
	dodoc README INSTALL ChangeLog TODO NEWS AUTHORS
}
