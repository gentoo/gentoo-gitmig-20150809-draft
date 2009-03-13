# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PostScript/PostScript-0.06.ebuild,v 1.1 2009/03/13 00:07:08 weaver Exp $

inherit perl-module

DESCRIPTION="An object that may be used to construct a block of text in PostScript"
HOMEPAGE="http://search.cpan.org/~shawnpw/PostScript-0.06/"
SRC_URI="mirror://cpan/authors/id/S/SH/SHAWNPW/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
SRC_TEST="do"

DEPEND="dev-lang/perl"
