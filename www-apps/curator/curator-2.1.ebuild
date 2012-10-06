# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/curator/curator-2.1.ebuild,v 1.4 2012/10/06 16:56:09 armin76 Exp $

DESCRIPTION="Webpage thumbnail creator"
HOMEPAGE="http://furius.ca/curator/"
SRC_URI="mirror://sourceforge/curator/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2.1
	>=media-gfx/imagemagick-5.4.9"

src_install() {
	dobin bin/curator || die "dobin bin/curator failed!"
	dodoc CHANGES README
}
