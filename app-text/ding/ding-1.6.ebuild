# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ding/ding-1.6.ebuild,v 1.1 2009/05/06 15:11:02 tove Exp $

inherit eutils

DESCRIPTION="Tk based dictionary (German-English) (incl. dictionary itself)"
HOMEPAGE="http://www-user.tu-chemnitz.de/~fri/ding/"
SRC_URI="http://wftp.tu-chemnitz.de/pub/Local/urz/ding/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/tk-8.3"

src_install() {
	dobin ding || die "dobin failed."
	insinto /usr/share/dict
	doins de-en.txt || die "doins failed."
	doman ding.1 || die
	dodoc CHANGES README || die

	doicon ding.png || die "problem with png."
	domenu ding.desktop || die ".desktop problem"
}
