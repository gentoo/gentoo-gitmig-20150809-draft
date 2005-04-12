# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXML-Iterator/XML-LibXML-Iterator-1.00.ebuild,v 1.7 2005/04/12 01:31:44 gustavoz Exp $

inherit perl-module

DESCRIPTION="No description available."
SRC_URI="http://www.cpan.org/modules/by-authors/id/P/PH/PHISH/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/P/PH/PHISH/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 alpha ~ppc sparc"
IUSE=""

DEPEND="dev-perl/XML-LibXML
	dev-perl/XML-NodeFilter"
