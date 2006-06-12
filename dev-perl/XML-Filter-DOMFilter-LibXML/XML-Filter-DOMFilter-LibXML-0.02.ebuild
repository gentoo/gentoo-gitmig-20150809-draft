# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Filter-DOMFilter-LibXML/XML-Filter-DOMFilter-LibXML-0.02.ebuild,v 1.3 2006/06/12 17:00:23 mcummings Exp $

inherit perl-module

DESCRIPTION="SAX Filter allowing DOM processing of selected subtrees"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/P/PA/PAJAS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ia64 sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/XML-LibXML-1.53"
