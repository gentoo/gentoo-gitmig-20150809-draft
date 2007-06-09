# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Number-Delta/Test-Number-Delta-1.03.ebuild,v 1.3 2007/06/09 13:53:38 jer Exp $

inherit perl-module versionator


DESCRIPTION="Perl interface to the cairo library"
HOMEPAGE="http://search.cpan.org/~tsch"
SRC_URI="mirror://cpan/authors/id/D/DA/DAGOLDEN/${P}.tar.gz"

IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"

SRC_TEST="do"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
		dev-perl/module-build"
