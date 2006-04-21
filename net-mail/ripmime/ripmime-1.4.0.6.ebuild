# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/ripmime/ripmime-1.4.0.6.ebuild,v 1.3 2006/04/21 18:23:24 gustavoz Exp $

DESCRIPTION="extract attachment files out of a MIME-encoded email pack"
HOMEPAGE="http://pldaniels.com/ripmime/"
SRC_URI="http://www.pldaniels.com/ripmime/${P}.tar.gz"

LICENSE="Sendmail"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE=""

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin ripmime || die
	doman ripmime.1
	dodoc CHANGELOG INSTALL README TODO
}
