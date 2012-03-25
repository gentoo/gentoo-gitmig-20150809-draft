# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Safe-Hole/Safe-Hole-0.10.ebuild,v 1.11 2012/03/25 16:59:59 armin76 Exp $

inherit perl-module

DESCRIPTION="Exec subs in the original package from Safe"
SRC_URI="mirror://cpan/authors/id/S/SE/SEYN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~seyn/"
IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 x86"

SRC_TEST="do"

DEPEND="dev-lang/perl"
