# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXML-XPathContext/XML-LibXML-XPathContext-0.06.ebuild,v 1.9 2005/05/01 18:27:33 slarti Exp $

inherit perl-module

DESCRIPTION="Perl interface to libxml2's xmlXPathContext"
SRC_URI="mirror://cpan/authors/id/I/IL/ILYAM/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/I/IL/ILYAM/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 sparc ~ppc amd64 ~alpha"
IUSE="gnome"

SRC_TEST="do"

DEPEND="dev-perl/XML-LibXML
		gnome? ( dev-perl/XML-GDOME )"
