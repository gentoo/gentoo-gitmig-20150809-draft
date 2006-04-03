# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Expect/Expect-1.15.ebuild,v 1.1 2006/04/03 18:22:18 mcummings Exp $

inherit perl-module

DESCRIPTION="Expect for Perl"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/R/RG/RGIERSIG/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""
SRC_TEST="do"

DEPEND=""
RDEPEND="dev-perl/IO-Tty"

