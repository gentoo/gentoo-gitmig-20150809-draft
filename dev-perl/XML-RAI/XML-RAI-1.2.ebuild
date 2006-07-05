# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RAI/XML-RAI-1.2.ebuild,v 1.4 2006/07/05 13:34:08 ian Exp $

inherit perl-module

DESCRIPTION="RSS Abstraction Interface."
HOMEPAGE="http://search.cpan.org/~tima/${P}/"
SRC_URI="mirror://cpan/authors/id/T/TI/TIMA/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

#SRC_TEST="do"

DEPEND=">=dev-perl/TimeDate-1.16
		dev-perl/XML-Elemental
		dev-perl/Class-XPath"
RDEPEND="${DEPEND}"