# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXML-Iterator/XML-LibXML-Iterator-1.00.ebuild,v 1.11 2006/07/05 13:28:58 ian Exp $

inherit perl-module

DESCRIPTION="No description available."
SRC_URI="mirror://cpan/authors/id/P/PH/PHISH/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/P/PH/PHISH/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
IUSE=""

DEPEND="dev-perl/XML-LibXML
	dev-perl/XML-NodeFilter"
RDEPEND="${DEPEND}"
