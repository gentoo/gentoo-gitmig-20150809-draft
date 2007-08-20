# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/jnettop/jnettop-0.13.0-r1.ebuild,v 1.2 2007/08/20 10:31:11 jokey Exp $

DESCRIPTION="A top like console network traffic visualiser"
HOMEPAGE="http://jnettop.kubs.info/"
SRC_URI="http://jnettop.kubs.info/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="net-libs/libpcap
	>=dev-libs/glib-2.0.1"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README .jnettop
}
