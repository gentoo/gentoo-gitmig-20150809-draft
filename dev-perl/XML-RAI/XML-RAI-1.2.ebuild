# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RAI/XML-RAI-1.2.ebuild,v 1.1 2005/02/07 10:15:51 mcummings Exp $

inherit perl-module

DESCRIPTION="RSS Abstraction Interface."
HOMEPAGE="http://search.cpan.org/~tima/${P}/"
SRC_URI="mirror://cpan/authors/id/T/TI/TIMA/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/TimeDate-1.16
		dev-perl/XML-Elemental
		dev-perl/Class-XPath"
