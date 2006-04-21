# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-IMAPClient/Mail-IMAPClient-2.2.9.ebuild,v 1.10 2006/04/21 01:11:48 vapier Exp $

inherit perl-module eutils

DESCRIPTION="IMAP client module for Perl"
SRC_URI="mirror://cpan/modules/by-module/Mail/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~ia64 ~ppc ~s390 sparc x86"
IUSE=""

# Tests are not enabled for this package intentionally. They require
# an active imap server to connect to, as well as interaction.
#SRC_TEST="do"

DEPEND=">=virtual/perl-libnet-1.0703
	dev-perl/Parse-RecDescent"

mydoc="FAQ"

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-skiptest.patch
}
