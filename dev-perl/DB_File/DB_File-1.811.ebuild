# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DB_File/DB_File-1.811.ebuild,v 1.3 2005/03/14 16:44:41 corsair Exp $

inherit perl-module

DESCRIPTION="A Berkeley DB Support Perl Module"
SRC_URI="mirror://cpan/authors/id/P/PM/PMQS/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/DB_File/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 sparc ~hppa ~alpha ~ia64 ~ppc amd64 ~mips ppc64"
IUSE=""

SRC_TEST="do"

DEPEND="${DEPEND}
	sys-libs/db"

mydoc="Changes"
