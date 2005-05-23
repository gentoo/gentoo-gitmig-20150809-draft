# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xclip/xclip-0.08.ebuild,v 1.5 2005/05/23 03:55:16 agriffis Exp $

S=${WORKDIR}/xclip
DESCRIPTION="Command-line utility to read data from standard in and place it in an X selection for pasting into X applications."
SRC_URI="http://people.debian.org/~kims/xclip/${P}.tar.gz"
HOMEPAGE="http://people.debian.org/~kims/xclip/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ppc x86"
IUSE=""

DEPEND="virtual/x11"

src_compile() {
	xmkmf || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	make DESTDIR=${D} install.man || die
	dodoc README INSTALL CHANGES
}
