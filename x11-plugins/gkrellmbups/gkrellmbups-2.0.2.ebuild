# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmbups/gkrellmbups-2.0.2.ebuild,v 1.3 2007/02/05 15:59:51 gustavoz Exp $

IUSE=""
DESCRIPTION="GKrellM2 Belkin UPS monitor Plugin"
SRC_URI="http://www.starforge.co.uk/gkrellm/files/${P}.tar.gz"
HOMEPAGE="http://www.starforge.co.uk/gkrellm/gkrellmbups.shtml"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~sparc ~x86"

DEPEND="=app-admin/gkrellm-2*"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:/usr/include/gkrell:/usr/include/gkrellm2:g' configure
}

src_compile() {
	econf || die
	emake || die
}

src_install () {
	insinto /usr/lib/gkrellm2/plugins
	newins src/gkrellmbups gkrellmbups.so
	dodoc COPYING INSTALL README TODO
}
