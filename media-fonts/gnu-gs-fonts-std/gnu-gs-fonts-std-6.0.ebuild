# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/gnu-gs-fonts-std/gnu-gs-fonts-std-6.0.ebuild,v 1.2 2003/12/09 18:07:17 lanius Exp $

DESCRIPTION="Ghostscript Standard Fonts"
HOMEPAGE="http://www.cups.org/"
SRC_URI="ftp://ftp.easysw.com/pub/ghostscript/${P}.tar.gz"
LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86 sparc alpha"
IUSE=""

DEPEND="virtual/ghostscript"
#RDEPEND=""

S=${WORKDIR}/fonts

src_install() {
	dodir /usr/share/fonts/default/ghostscript
	insinto /usr/share/fonts/default/ghostscript
	doins *
}
