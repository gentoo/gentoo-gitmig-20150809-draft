# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-IMAPClient/Mail-IMAPClient-3.06.ebuild,v 1.1 2008/04/24 16:47:52 yuval Exp $

inherit perl-module eutils

DESCRIPTION="IMAP client module for Perl"
HOMEPAGE="http://search.cpan.org/~djkernen/"
SRC_URI="mirror://cpan/modules/by-module/Mail/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=">=virtual/perl-libnet-1.0703
	dev-perl/Parse-RecDescent
	dev-lang/perl"

SRC_TEST="do"

mydoc="FAQ"
