# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/ripmime/ripmime-1.3.0.5.ebuild,v 1.4 2004/07/15 02:26:30 agriffis Exp $

DESCRIPTION="ripMIME extracts attachment files out of a MIME-encoded email pack"
SRC_URI="http://www.pldaniels.com/ripmime/${P}.tar.gz"
HOMEPAGE="http://pldaniels.com/ripmime/"

SLOT="0"
LICENSE="Sendmail"
KEYWORDS="~x86 ~sparc"
IUSE=""

src_compile() {
	emake || die
}

src_install () {
	dobin ripmime
	dodoc CHANGELOG INSTALL LICENSE README TODO
}
