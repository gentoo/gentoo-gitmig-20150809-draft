# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXML-XPathContext/XML-LibXML-XPathContext-0.05.ebuild,v 1.2 2003/12/30 12:50:35 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl interface to libxml2's xmlXPathContext"
SRC_URI="http://www.cpan.org/modules/by-authors/id/I/IL/ILYAM/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/I/IL/ILYAM/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 sparc ~ppc"

DEPEND="dev-perl/XML-LibXML
		gnome? ( dev-perl/XML-GDOME )"
