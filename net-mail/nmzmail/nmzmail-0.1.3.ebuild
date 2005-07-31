# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/nmzmail/nmzmail-0.1.3.ebuild,v 1.2 2005/07/31 11:15:55 dholm Exp $

DESCRIPTION="Fast mail searchng for mutt using namazu"
HOMEPAGE="http://www.ecademix.com/JohannesHofmann/#nmzmail"
SRC_URI="http://www.ecademix.com/JohannesHofmann/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="sys-libs/readline"
RDEPEND=">=app-text/namazu-2"

src_compile() {
	econf || die "could not configure"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dodoc README AUTHORS NEWS
}

