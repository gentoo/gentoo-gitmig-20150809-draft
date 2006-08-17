# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-DomainKeys/Mail-DomainKeys-0.80.ebuild,v 1.14 2006/08/17 21:41:21 mcummings Exp $

inherit perl-module

DESCRIPTION="A perl implementation of DomainKeys"
HOMEPAGE="http://search.cpan.org/~anthonyu/${P}"
SRC_URI="mirror://cpan/authors/id/A/AN/ANTHONYU/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc ppc64 sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/Net-DNS
	dev-perl/MailTools
		dev-perl/Crypt-OpenSSL-RSA
	dev-lang/perl"
RDEPEND="${DEPEND}"

