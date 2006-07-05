# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ggz-client-libs/ggz-client-libs-0.0.13.ebuild,v 1.2 2006/07/05 14:09:51 wolf31o2 Exp $

DESCRIPTION="The client libraries for GGZ Gaming Zone"
HOMEPAGE="http://www.ggzgamingzone.org/"
SRC_URI="http://ftp.belnet.be/packages/ggzgamingzone/ggz/${PV}/${P}.tar.gz
	http://mirrors.ibiblio.org/pub/mirrors/ggzgamingzone/ggz/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="~dev-games/libggz-0.0.13
	dev-libs/expat
	dev-libs/popt"

src_compile() {
	econf --sysconfdir=/etc/ggz || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS Quick* README*
}

