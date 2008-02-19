# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/curator/curator-2.1.ebuild,v 1.3 2008/02/19 11:57:36 hollow Exp $

DESCRIPTION="Webpage thumbnail creator"
HOMEPAGE="http://furius.ca/curator/"
SRC_URI="mirror://sourceforge/curator/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2.1
	>=media-gfx/imagemagick-5.4.9"

src_install() {
	dobin bin/curator || die "dobin bin/curator failed!"
	dodoc CHANGES README
}
