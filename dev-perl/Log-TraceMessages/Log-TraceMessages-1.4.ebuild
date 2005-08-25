# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Log-TraceMessages/Log-TraceMessages-1.4.ebuild,v 1.8 2005/08/25 23:25:38 agriffis Exp $

inherit perl-module

DESCRIPTION="Logging/debugging aid"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/EDAVIS/${P}/"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"
SRC_TEST="do"
DEPEND=">=dev-perl/HTML-FromText-1.004"
