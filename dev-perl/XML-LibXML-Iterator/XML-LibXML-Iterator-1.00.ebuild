# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXML-Iterator/XML-LibXML-Iterator-1.00.ebuild,v 1.1 2003/06/17 12:03:06 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="No description available."
SRC_URI="http://www.cpan.org/modules/by-authors/id/P/PH/PHISH/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/P/PH/PHISH/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~alpha ~ppc ~sparc"

DEPEND="dev-perl/XML-LibXML
	dev-perl/XML-NodeFilter"

