# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/clamassassin/clamassassin-1.2.0.ebuild,v 1.2 2004/08/06 11:56:30 slarti Exp $

DESCRIPTION="clamassassin is a simple script for virus scanning (through clamav) an e-mail message as a
filter (like spamassassin)"
HOMEPAGE="http://drivel.com/clamassassin/"
SRC_URI="http://drivel.com/clamassassin/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="subjectrewrite"
DEPEND=">=app-antivirus/clamav-0.71
		sys-apps/debianutils
		sys-apps/which
		virtual/mda" # This is because clamassassin needs formail which is
					 # both in procmail and maildrop. Is this the right
					 # dependency?

src_compile() {
	econf $(use_enable subjectrewrite) || die
}

src_install() {
	dobin clamassassin
	dodoc CHANGELOG LICENSE README
}
