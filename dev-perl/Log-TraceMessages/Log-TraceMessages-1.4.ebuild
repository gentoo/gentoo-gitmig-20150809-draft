# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Log-TraceMessages/Log-TraceMessages-1.4.ebuild,v 1.3 2004/10/16 23:57:22 rac Exp $

inherit perl-module

DESCRIPTION="Logging/debugging aid"
SRC_URI="http://www.cpan.org/modules/by-module/Log/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/EDAVIS/${P}/"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
SRC_TEST="do"
DEPEND=">=dev-perl/HTML-FromText-1.004"
