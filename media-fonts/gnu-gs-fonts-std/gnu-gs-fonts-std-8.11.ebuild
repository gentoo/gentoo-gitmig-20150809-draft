# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/gnu-gs-fonts-std/gnu-gs-fonts-std-8.11.ebuild,v 1.2 2004/10/16 14:26:28 chrb Exp $

MY_PN=ghostscript-fonts-std
MY_P=${MY_PN}-${PV}

DESCRIPTION="Ghostscript Standard Fonts"
HOMEPAGE="http://www.cups.org/"
SRC_URI="mirror://sourceforge/ghostscript/${MY_P}.tar.gz"
LICENSE="GPL-1"
SLOT="0"
KEYWORDS="ia64 x86 ppc hppa mips ppc64 sparc alpha amd64"
IUSE=""

DEPEND=""

S=${WORKDIR}/fonts

src_install() {
	dodir /usr/share/fonts/default/ghostscript
	insinto /usr/share/fonts/default/ghostscript
	doins *
}
