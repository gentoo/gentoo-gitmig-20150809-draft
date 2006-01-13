# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-XUpdate-LibXML/XML-XUpdate-LibXML-0.6.0.ebuild,v 1.2 2006/01/13 22:40:16 mcummings Exp $

IUSE=""
inherit perl-module
DESCRIPTION="Process XUpdate commands over an XML document."
SRC_URI="mirror://cpan/authors/id/P/PA/PAJAS/${P}.tar.gz"
HOMEPAGE="http:/search.cpan.org/~pajas/XML-XUpdate-LibXML-0.6.0/"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ppc sparc x86"

SRC_TEST="do"

DEPEND=">=dev-perl/XML-LibXML-1.54
		dev-perl/XML-LibXML-XPathContext
		dev-perl/XML-LibXML-Iterator"
