# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Event/Event-1.05.ebuild,v 1.2 2005/07/09 23:06:04 swegener Exp $

inherit perl-module

DESCRIPTION="fast, generic event loop"
SRC_URI="mirror://cpan/authors/id/J/JP/JPRIT/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Event/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
IUSE=""
SRC_TEST="do"

mydoc="ANNOUNCE INSTALL TODO Tutorial.pdf"
