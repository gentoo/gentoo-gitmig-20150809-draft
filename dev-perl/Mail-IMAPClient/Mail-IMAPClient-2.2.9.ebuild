# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-IMAPClient/Mail-IMAPClient-2.2.9.ebuild,v 1.3 2005/01/15 16:38:26 mcummings Exp $

inherit perl-module eutils

CATEGORY="dev-perl"
DESCRIPTION="IMAP client module for Perl"
SRC_URI="mirror://cpan/modules/by-module/Mail/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 sparc"
IUSE=""

# Tests are not enabled for this package intentionally. They require
# an active imap server to connect to, as well as interaction.
#SRC_TEST="do"

DEPEND="${DEPEND}
	>=dev-perl/libnet-1.0703
	dev-perl/Parse-RecDescent"

mydoc="FAQ"

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-skiptest.patch
}
