# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/grabcartoons/grabcartoons-2.1.ebuild,v 1.1 2007/10/15 07:48:23 opfer Exp $

DESCRIPTION="comic-summarizing utility"
HOMEPAGE="http://grabcartoons.sourceforge.net/"
SRC_URI="mirror://sourceforge/grabcartoons/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_install() {
	emake PREFIX="${D}"/usr install || die
	dodoc ChangeLog README
}
