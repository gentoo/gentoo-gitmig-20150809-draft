# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-GDOME/XML-GDOME-0.85.ebuild,v 1.1 2003/12/30 16:54:14 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Provides the DOM Level 2 Core API for accessing XML documents"
SRC_URI="http://search.cpan.org/CPAN/authors/id/T/TJ/TJMATHER/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/T/TJ/TJMATHER/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 sparc ~ppc"

DEPEND=">=dev-libs/gdome2-0.7.2
		dev-perl/XML-LibXML-Common
		dev-perl/XML-SAX"
