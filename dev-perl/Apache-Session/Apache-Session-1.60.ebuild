# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-Session/Apache-Session-1.60.ebuild,v 1.1 2004/06/13 13:45:53 mcummings Exp $

inherit perl-module
MY_PV=${PV/0/}
MY_P=${PN}-${MY_PV}
IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Perl module for Apache::Session"
SRC_URI="http://search.cpan.org/CPAN/authors/id/J/JB/JBAKER/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~jbaker/${MY_P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}
	dev-perl/Digest-MD5
	dev-perl/Storable"
