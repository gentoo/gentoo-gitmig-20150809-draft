# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnu-gs-fonts-std/gnu-gs-fonts-std-6.0.ebuild,v 1.1 2003/01/27 21:10:32 lordvan Exp $

DESCRIPTION="Ghostscript Standard Fonts"
HOMEPAGE="http://www.cups.com/"
SRC_URI="ftp://ftp.easysw.com/pub/ghostscript/${P}.tar.gz"
LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha"
IUSE=""

DEPEND="app-text/ghostscript"
#RDEPEND=""

S=${WORKDIR}/fonts

src_install() {
	dodir /usr/share/fonts/default/ghostscript
	insinto /usr/share/fonts/default/ghostscript
	doins *
}
