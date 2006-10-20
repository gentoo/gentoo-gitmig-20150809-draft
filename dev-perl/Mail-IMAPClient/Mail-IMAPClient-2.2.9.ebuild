# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-IMAPClient/Mail-IMAPClient-2.2.9.ebuild,v 1.18 2006/10/20 19:53:04 kloeri Exp $

inherit perl-module eutils

DESCRIPTION="IMAP client module for Perl"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"
SRC_URI="mirror://cpan/modules/by-module/Mail/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc s390 sh sparc x86"
IUSE=""

DEPEND=">=virtual/perl-libnet-1.0703
	dev-perl/Parse-RecDescent
	dev-lang/perl"
RDEPEND="${DEPEND}"

# Tests are not enabled for this package intentionally. They require
# an active imap server to connect to, as well as interaction.
#SRC_TEST="do"

mydoc="FAQ"

src_unpack(){
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-skiptest.patch
}
