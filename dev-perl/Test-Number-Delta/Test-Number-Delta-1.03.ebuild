# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Number-Delta/Test-Number-Delta-1.03.ebuild,v 1.18 2011/05/11 08:40:03 xmw Exp $

inherit perl-module versionator

DESCRIPTION="Perl interface to the cairo library"
HOMEPAGE="http://search.cpan.org/~tsch"
SRC_URI="mirror://cpan/authors/id/D/DA/DAGOLDEN/${P}.tar.gz"

IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"

SRC_TEST="do"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
		virtual/perl-Module-Build"
