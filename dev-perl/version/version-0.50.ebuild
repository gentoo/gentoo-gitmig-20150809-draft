# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/version/version-0.50.ebuild,v 1.1 2005/12/21 15:29:01 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl extension for Version Objects"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/J/JP/JPEACOCK/${P}.tar.gz"

LICENSE="|| (Artistic GPL-2)"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""
SRC_TEST="do"

DEPEND=">=dev-perl/module-build-0.26.11"
RDEPEND=""

