# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Elemental/XML-Elemental-2.11.ebuild,v 1.1 2009/11/26 08:01:07 robbat2 Exp $

MODULE_AUTHOR=TIMA
inherit perl-module

DESCRIPTION="an XML::Parser style and generic classes for simplistic and perlish handling of XML data. "

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/XML-Parser
	dev-perl/XML-SAX
	dev-perl/Class-Accessor
	dev-lang/perl"
RDEPEND="${DEPEND}"
