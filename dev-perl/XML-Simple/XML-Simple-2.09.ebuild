# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Simple/XML-Simple-2.09.ebuild,v 1.9 2005/05/25 14:42:58 mcummings Exp $

inherit perl-module

IUSE=""
DESCRIPTION="XML::Simple - Easy API to read/write XML (esp config files)"
SRC_URI="http://www.cpan.org/modules/by-module/XML/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/XML/${P}.readme"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}
	perl-core/Storable
	dev-perl/Test-Simple
	dev-perl/XML-SAX
	dev-perl/XML-NamespaceSupport
	>=dev-perl/XML-Parser-2.30"
