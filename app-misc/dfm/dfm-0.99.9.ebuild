# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/dfm/dfm-0.99.9.ebuild,v 1.2 2002/07/25 16:55:21 seemant Exp $

S=${WORKDIR}/dfm
DESCRIPTION="Desktop Manager. Good replacement for gmc or nautilus"
SRC_URI="http://www.kaisersite.de/dfm/${P}.tar.gz"
HOMEPAGE="http://www.kaisersite.de/dfm/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="=x11-libs/gtk+-1.2*
	=media-libs/imlib-1.9*"

src_compile() {
	econf || die
	emake || die
}

src_install () {

	einstall || die

	dodoc README INSTALL ChangeLog TODO NEWS AUTHORS
}
