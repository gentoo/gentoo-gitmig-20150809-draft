# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Event/Event-0.87.ebuild,v 1.13 2006/02/13 11:07:22 mcummings Exp $

inherit perl-module

DESCRIPTION="fast, generic event loop"

# Moved to Gentoo mirrors as it's vanished from the CPAN archives
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Event/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""
DEPEND="virtual/perl-Test"

mydoc="ANNOUNCE INSTALL TODO Tutorial.pdf"
