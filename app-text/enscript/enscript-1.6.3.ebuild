# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/enscript/enscript-1.6.3.ebuild,v 1.15 2004/08/07 21:27:01 slarti Exp $

DESCRIPTION="powerful text-to-postscript converter"
SRC_URI="http://www.iki.fi/mtr/genscript/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/enscript/enscript.html"

KEYWORDS="x86 sparc"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND="sys-devel/flex
	sys-devel/bison"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog FAQ.html NEWS README* THANKS TODO
}

pkg_postinst() {
	einfo "Now, customize /etc/enscript.cfg"
}
