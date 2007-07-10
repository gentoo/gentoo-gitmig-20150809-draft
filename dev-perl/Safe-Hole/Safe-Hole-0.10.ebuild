# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Safe-Hole/Safe-Hole-0.10.ebuild,v 1.10 2007/07/10 23:33:30 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Exec subs in the original package from Safe"
SRC_URI="mirror://cpan/authors/id/S/SE/SEYN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~seyn/"
IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 sparc x86"

SRC_TEST="do"

DEPEND="dev-lang/perl"
