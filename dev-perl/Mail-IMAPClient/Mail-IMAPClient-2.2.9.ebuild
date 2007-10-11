# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-IMAPClient/Mail-IMAPClient-2.2.9.ebuild,v 1.20 2007/10/11 11:23:34 corsair Exp $

inherit perl-module eutils

DESCRIPTION="IMAP client module for Perl"
HOMEPAGE="http://search.cpan.org/~djkernen/"
SRC_URI="mirror://cpan/modules/by-module/Mail/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ~ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=">=virtual/perl-libnet-1.0703
	dev-perl/Parse-RecDescent
	dev-lang/perl"

# Tests are not enabled for this package intentionally. They require
# an active imap server to connect to, as well as interaction.
#SRC_TEST="do"

mydoc="FAQ"

src_unpack(){
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-skiptest.patch
}
