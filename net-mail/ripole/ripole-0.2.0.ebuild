# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/ripole/ripole-0.2.0.ebuild,v 1.3 2009/09/23 19:12:19 patrick Exp $

DESCRIPTION="Program/library to pull out attachment from OLE2 data files"
HOMEPAGE="http://www.pldaniels.com/ripole/"
SRC_URI="http://www.pldaniels.com/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=""

src_compile() {
	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin ripole
	dodoc CHANGELOG INSTALL README TODO LICENSE CONTRIBUTORS
}
