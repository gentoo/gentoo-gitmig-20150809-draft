# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/clamassassin/clamassassin-1.2.1.ebuild,v 1.1 2004/08/31 16:10:11 ticho Exp $

DESCRIPTION="clamassassin is a simple script for virus scanning (through clamav) an e-mail message as a
filter (like spamassassin)"
HOMEPAGE="http://drivel.com/clamassassin/"
SRC_URI="http://drivel.com/clamassassin/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="subject-rewrite"
DEPEND=">=app-antivirus/clamav-0.75.1
		sys-apps/debianutils
		sys-apps/which
		virtual/mda" # This is because clamassassin needs formail which is
					 # both in procmail and maildrop. Is this the right
					 # dependency?

src_compile() {
	econf $(use_enable subject-rewrite) || die
	# Fix problems with Portage exporting TMP and breaking clamassassin. #61806
	sed -i -e "s:${TMP}:/tmp:" clamassassin
}

src_install() {
	dobin clamassassin
	dodoc CHANGELOG LICENSE README
}
