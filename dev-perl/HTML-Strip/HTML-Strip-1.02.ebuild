# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Strip/HTML-Strip-1.02.ebuild,v 1.14 2006/08/05 04:27:46 mcummings Exp $

inherit perl-module

DESCRIPTION="automate interaction with bugzilla"
SRC_URI="mirror://cpan/authors/id/K/KI/KILINRAX/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~kilinrax/${P}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc amd64 sparc ppc64"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
