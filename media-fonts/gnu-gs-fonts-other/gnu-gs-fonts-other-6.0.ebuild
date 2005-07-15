# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/gnu-gs-fonts-other/gnu-gs-fonts-other-6.0.ebuild,v 1.11 2005/07/15 17:01:55 flameeyes Exp $

DESCRIPTION="Ghostscript Extra Fonts"
HOMEPAGE="http://www.cups.org/"
SRC_URI="ftp://ftp.easysw.com/pub/ghostscript/${P}.tar.gz"
LICENSE="GPL-1"
SLOT="0"
KEYWORDS="alpha amd64 ppc ~ppc-macos ppc64 sparc x86"
IUSE=""
DEPEND=""
S=${WORKDIR}/fonts

src_install() {
	dodir /usr/share/fonts/default/ghostscript
	insinto /usr/share/fonts/default/ghostscript
	doins *
}
