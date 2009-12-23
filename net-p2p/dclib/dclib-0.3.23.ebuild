# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dclib/dclib-0.3.23.ebuild,v 1.3 2009/12/23 17:12:08 hwoarang Exp $

DESCRIPTION="DirectConnect client library"
HOMEPAGE="http://sourceforge.net/projects/wxdcgui"
SRC_URI="mirror://sourceforge/wxdcgui/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=app-arch/bzip2-1.0.2
	>=dev-libs/libxml2-2.4.22"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
