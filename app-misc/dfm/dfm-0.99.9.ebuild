# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dfm/dfm-0.99.9.ebuild,v 1.7 2003/02/13 08:55:33 vapier Exp $

DESCRIPTION="Desktop Manager. Good replacement for gmc or nautilus"
SRC_URI="http://www.kaisersite.de/dfm/${P}.tar.gz"
HOMEPAGE="http://www.kaisersite.de/dfm/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="=x11-libs/gtk+-1.2*
	=media-libs/imlib-1.9*"

S=${WORKDIR}/${PN}

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall
	dodoc README INSTALL ChangeLog TODO NEWS AUTHORS
}
