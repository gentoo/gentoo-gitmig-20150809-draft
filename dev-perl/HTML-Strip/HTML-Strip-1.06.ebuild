# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Strip/HTML-Strip-1.06.ebuild,v 1.5 2006/08/07 23:30:10 mcummings Exp $

inherit perl-module

DESCRIPTION="automate interaction with bugzilla"
SRC_URI="mirror://cpan/authors/id/K/KI/KILINRAX/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~kilinrax/${P}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ia64 ~ppc ~ppc64 sparc ~x86"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
