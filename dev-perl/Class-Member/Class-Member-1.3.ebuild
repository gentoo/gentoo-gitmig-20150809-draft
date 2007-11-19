# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Member/Class-Member-1.3.ebuild,v 1.2 2007/11/19 19:42:48 flameeyes Exp $

inherit perl-module

DESCRIPTION="Class::Member - A set of modules to make the module developement easier"
HOMEPAGE="http://search.cpan.org/~opi/${P}/"
SRC_URI="mirror://cpan/authors/id/O/OP/OPI/${P}.tar.gz"
SRC_TEST="do"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl"
