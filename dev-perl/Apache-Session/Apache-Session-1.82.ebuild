# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-Session/Apache-Session-1.82.ebuild,v 1.2 2007/06/21 14:33:02 mcummings Exp $

inherit perl-module
IUSE=""

DESCRIPTION="Perl module for Apache::Session"
SRC_URI="mirror://cpan/authors/id/C/CH/CHORNY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~chorny/"

SLOT="0"
LICENSE="Artistic"
#KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc sparc ~x86"

DEPEND="dev-perl/Test-Deep
	virtual/perl-Digest-MD5
	virtual/perl-Storable
	dev-lang/perl"
