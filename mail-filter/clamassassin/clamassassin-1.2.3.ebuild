# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/clamassassin/clamassassin-1.2.3.ebuild,v 1.2 2006/03/13 14:22:42 ticho Exp $

DESCRIPTION="clamassassin is a simple script for virus scanning (through clamav) an e-mail message as a
filter (like spamassassin)"
HOMEPAGE="http://drivel.com/clamassassin/"
SRC_URI="http://drivel.com/clamassassin/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="subject-rewrite clamd"
DEPEND=">=app-antivirus/clamav-0.75.1
		sys-apps/debianutils
		sys-apps/which
		mail-filter/procmail"

src_compile() {
	econf \
		$(use_enable subject-rewrite) \
		$(use_enable clamd clamdscan) \
		|| die
	# Fix problems with Portage exporting TMP and breaking clamassassin. #61806
	sed -i -e "s:${TMP}:/tmp:" clamassassin
}

src_install() {
	dobin clamassassin
	dodoc CHANGELOG LICENSE README
}
