# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-XPathEngine/XML-XPathEngine-0.11.ebuild,v 1.2 2009/03/16 01:53:26 weaver Exp $

inherit perl-module

DESCRIPTION="A re-usable XPath engine for DOM-like trees"
HOMEPAGE="http://search.cpan.org/~mirod/${P}/lib/XML/XPathEngine.pm"
SRC_URI="mirror://cpan/authors/id/M/MI/MIROD/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
SRC_TEST="do"

DEPEND="dev-lang/perl"
