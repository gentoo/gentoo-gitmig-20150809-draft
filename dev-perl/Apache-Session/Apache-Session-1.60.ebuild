# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-Session/Apache-Session-1.60.ebuild,v 1.3 2004/06/25 00:05:40 agriffis Exp $

inherit perl-module
MY_PV=${PV/0/}
MY_P=${PN}-${MY_PV}
IUSE=""

S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl module for Apache::Session"
SRC_URI="http://search.cpan.org/CPAN/authors/id/J/JB/JBAKER/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~jbaker/${MY_P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}
	dev-perl/Digest-MD5
	dev-perl/Storable"
