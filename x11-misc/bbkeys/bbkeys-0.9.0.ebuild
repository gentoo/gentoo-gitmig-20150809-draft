# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbkeys/bbkeys-0.9.0.ebuild,v 1.4 2005/06/17 21:03:31 hansmi Exp $

DESCRIPTION="Use keyboard shortcuts in the blackbox wm"
HOMEPAGE="http://bbkeys.sourceforge.net"
SRC_URI="mirror://sourceforge/bbkeys/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND=">=x11-wm/blackbox-0.70.0"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr || die "./configure failed"
	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		install || die
	rm -rf ${D}/usr/doc
	dodoc AUTHORS BUGS ChangeLog NEWS README
}
