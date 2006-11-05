# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-DomainKeys/Mail-DomainKeys-0.84.ebuild,v 1.3 2006/11/05 17:04:53 opfer Exp $

inherit perl-module

DESCRIPTION="A perl implementation of DomainKeys"
HOMEPAGE="http://search.cpan.org/~anthonyu/${P}"
SRC_URI="mirror://cpan/authors/id/A/AN/ANTHONYU/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc x86"
IUSE="test"
SRC_TEST="do"

DEPEND=">=dev-perl/Net-DNS-0.34
	dev-perl/MailTools
	dev-perl/Crypt-OpenSSL-RSA
	test? ( dev-perl/Email-Address )
	dev-lang/perl"


