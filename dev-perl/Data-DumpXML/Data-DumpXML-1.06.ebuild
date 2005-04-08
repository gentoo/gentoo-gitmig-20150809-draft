# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-DumpXML/Data-DumpXML-1.06.ebuild,v 1.3 2005/04/08 12:57:48 mcummings Exp $
inherit perl-module

DESCRIPTION="Dump arbitrary data structures as XML"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~GAAS/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/MIME-Base64-2
		>=dev-perl/XML-Parser-2
		>=dev-perl/Array-RefElem-0.01"
