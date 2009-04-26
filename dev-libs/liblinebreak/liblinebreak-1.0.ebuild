# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/liblinebreak/liblinebreak-1.0.ebuild,v 1.2 2009/04/26 14:18:31 ranger Exp $

EAPI="2"

DESCRIPTION="Line breaking library"
HOMEPAGE="http://vimgadgets.sourceforge.net/liblinebreak/"
SRC_URI="mirror://sourceforge/vimgadgets/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
