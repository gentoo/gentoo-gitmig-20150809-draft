# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsnow/xsnow-1.42.ebuild,v 1.15 2004/11/12 19:02:51 blubb Exp $

DESCRIPTION="snow, reindeer, and santa on the root window"
SRC_URI="http://www.euronet.nl/~rja/Xsnow/${P}.tar.gz"
HOMEPAGE="http://www.euronet.nl/~rja/Xsnow/"

SLOT="0"
KEYWORDS="x86 sparc ppc ppc64 ~amd64"
LICENSE="as-is"
IUSE=""

DEPEND="virtual/x11"

src_compile() {
	xmkmf || die
	make depend || die
	emake || die
}

src_install () {
	into /usr
	dobin xsnow || die
	rman -f HTML < xsnow._man > xsnow.1-html && \
		mv -f xsnow.1-html xsnow.1.html && \
		mv -f xsnow._man xsnow.1
	doman xsnow.1
	dodoc xsnow.1.html README
}
