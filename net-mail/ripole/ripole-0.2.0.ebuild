# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/ripole/ripole-0.2.0.ebuild,v 1.6 2010/03/19 17:01:48 jer Exp $

DESCRIPTION="Program/library to pull out attachment from OLE2 data files"
HOMEPAGE="http://www.pldaniels.com/ripole/"
SRC_URI="http://www.pldaniels.com/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 hppa x86"
IUSE=""

DEPEND=""

src_compile() {
	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin ripole
	dodoc CHANGELOG INSTALL README TODO CONTRIBUTORS
}
