# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xautomation/xautomation-0.96.ebuild,v 1.3 2005/07/02 18:06:18 kloeri Exp $

DESCRIPTION="Control X from command line and find things on screen"
HOMEPAGE="http://hoopajoo.net/projects/xautomation.html"
SRC_URI="http://hoopajoo.net/static/projects/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~ia64 ~ppc x86"
IUSE=""
DEPEND=""

src_compile() {
	econf || die 'econf failed'
	emake || die 'emake failed'
}

src_install() {
	make DESTDIR=${D} install || die 'make install failed'
	dodoc AUTHORS ChangeLog
}
