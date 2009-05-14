# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcue/libcue-1.3.0.ebuild,v 1.2 2009/05/14 08:03:26 ssuominen Exp $

EAPI=2
DESCRIPTION="CUE Sheet Parser Library"
HOMEPAGE="http://libcue.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="sys-devel/flex
	|| ( dev-util/yacc sys-devel/bison )"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS
}
