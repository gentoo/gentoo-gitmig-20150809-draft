# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/gnu-gs-fonts-std/gnu-gs-fonts-std-8.11.ebuild,v 1.4 2004/11/04 05:47:51 vapier Exp $

MY_PN=ghostscript-fonts-std
MY_P=${MY_PN}-${PV}

DESCRIPTION="Ghostscript Standard Fonts"
HOMEPAGE="http://www.cups.org/"
SRC_URI="mirror://sourceforge/ghostscript/${MY_P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ~ppc-macos s390 sparc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/fonts

src_install() {
	insinto /usr/share/fonts/default/ghostscript
	doins * || die
}
