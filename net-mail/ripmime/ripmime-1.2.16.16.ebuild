# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/ripmime/ripmime-1.2.16.16.ebuild,v 1.1 2002/07/10 20:48:54 bass Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="ripMIME extracts attachment files out of a MIME-encoded email pack."
SRC_URI="http://www.pldaniels.com/ripmime/${P}.tar.gz"
HOMEPAGE="http://www.pldaniels.com/ripmime"
LICENSE="GPL-2"
DEPEND=""
RDEPEND="${DEPEND}"
SLOT="0"

src_compile() {
	emake || die
}

src_install () {
	dobin ripmime
	dodoc CHANGELOG INSTALL LICENSE README TODO
}
