# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/altermime/altermime-0.3.3.ebuild,v 1.4 2004/07/15 01:29:16 agriffis Exp $

DESCRIPTION=" alterMIME is a small program which is used to alter your mime-encoded mailpacks"
SRC_URI="http://www.pldaniels.com/altermime/${P}.tar.gz"
HOMEPAGE="http://pldaniels.com/altermime/"

LICENSE="Sendmail"
KEYWORDS="~x86 s390"
IUSE=""
SLOT="0"

src_compile() {
	emake || die
}

src_install () {
	dobin altermime
	dodoc CHANGELOG INSTALL LICENSE README TODO
}
