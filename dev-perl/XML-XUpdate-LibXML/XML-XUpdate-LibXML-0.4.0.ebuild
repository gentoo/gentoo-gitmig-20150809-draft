# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-XUpdate-LibXML/XML-XUpdate-LibXML-0.4.0.ebuild,v 1.3 2003/06/21 21:36:44 drobbins Exp $

IUSE=""
inherit perl-module
DESCRIPTION="Process XUpdate commands over an XML document."
SRC_URI="http://www.cpan.org/CPAN/modules/by-module/XML/${P}.tar.gz"
HOMEPAGE="http:/search.cpan.org/author/PAJAS/${P}/"
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha"

DEPEND="dev-perl/XML-LibXML
		dev-perl/XML-LibXML-Iterator"
