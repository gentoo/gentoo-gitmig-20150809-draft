# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Versions-Report/Module-Versions-Report-1.02.ebuild,v 1.9 2006/07/10 16:53:51 agriffis Exp $

# this is an RT dependency

inherit perl-module

DESCRIPTION="Report versions of all modules in memory"
SRC_URI="mirror://cpan/authors/id/S/SB/SBURKE/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/S/SB/SBURKE/${P}.readme"

SRC_TEST="do"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="ia64 ~ppc sparc x86"
IUSE=""
