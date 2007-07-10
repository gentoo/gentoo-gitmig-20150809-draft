# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Error/Error-0.17.ebuild,v 1.8 2007/07/10 23:33:33 mr_bones_ Exp $

inherit versionator perl-module

DESCRIPTION="Error/exception handling in an OO-ish way"
SRC_URI="mirror://cpan/authors/id/S/SH/SHLOMIF/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Error/"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 ~mips ppc ~ppc64 s390 sh sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
