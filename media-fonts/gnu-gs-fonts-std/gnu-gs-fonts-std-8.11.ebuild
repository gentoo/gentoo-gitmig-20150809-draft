# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/gnu-gs-fonts-std/gnu-gs-fonts-std-8.11.ebuild,v 1.1 2004/09/29 09:59:50 lanius Exp $

MY_PN=ghostscript-fonts-std
MY_P=${MY_PN}-${PV}

DESCRIPTION="Ghostscript Standard Fonts"
HOMEPAGE="http://www.cups.org/"
SRC_URI="ftp://ftp.easysw.com/pub/ghostscript/${MY_P}.tar.gz"
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
