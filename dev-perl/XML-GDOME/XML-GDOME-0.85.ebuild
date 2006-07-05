# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-GDOME/XML-GDOME-0.85.ebuild,v 1.8 2006/07/05 13:24:07 ian Exp $

inherit perl-module

DESCRIPTION="Provides the DOM Level 2 Core API for accessing XML documents"
SRC_URI="mirror://cpan/authors/id/T/TJ/TJMATHER/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/T/TJ/TJMATHER/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 sparc ~ppc"
IUSE=""

DEPEND="=dev-libs/gdome2-0.7.2*
		dev-perl/XML-LibXML-Common
		dev-perl/XML-SAX"
RDEPEND="${DEPEND}"
