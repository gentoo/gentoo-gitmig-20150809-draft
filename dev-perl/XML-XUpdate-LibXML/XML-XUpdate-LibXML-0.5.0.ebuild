# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-XUpdate-LibXML/XML-XUpdate-LibXML-0.5.0.ebuild,v 1.5 2005/04/30 10:47:49 kloeri Exp $

IUSE=""
inherit perl-module
DESCRIPTION="Process XUpdate commands over an XML document."
SRC_URI="mirror://cpan/authors/id/P/PA/PAJAS/${P}.tar.gz"
HOMEPAGE="http:/search.cpan.org/~pajas/${P}/"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~ppc sparc ~amd64 ~alpha"

SRC_TEST="do"

DEPEND=">=dev-perl/XML-LibXML-1.54
		dev-perl/XML-LibXML-XPathContext
		dev-perl/XML-LibXML-Iterator"
