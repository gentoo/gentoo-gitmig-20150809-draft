# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tree-Simple/Tree-Simple-1.05.ebuild,v 1.4 2004/10/16 23:57:23 rac Exp $

# this is an RT dependency

inherit perl-module

DESCRIPTION="A simple tree object"
SRC_URI="http://www.cpan.org/modules/by-authors/id/S/ST/STEVAN/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/S/ST/STEVAN/${P}.readme"

SRC_TEST="do"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~ppc"

DEPEND="dev-perl/Test-Simple
	dev-perl/Test-Exception"
IUSE=""
