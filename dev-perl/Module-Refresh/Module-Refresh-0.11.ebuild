# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Refresh/Module-Refresh-0.11.ebuild,v 1.2 2007/07/10 23:33:27 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Refresh %INC files when updated on disk"
HOMEPAGE="http://search.cpan.org/~jesse/"
SRC_URI="mirror://cpan/authors/id/J/JE/JESSE/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
