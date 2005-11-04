# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-mysql/DBD-mysql-2.9007.ebuild,v 1.7 2005/11/04 18:51:46 gustavoz Exp $

inherit perl-module

DESCRIPTION="The Perl DBD:mysql Module"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/C/CA/CAPTTOFU/${P}.readme"
SRC_URI="mirror://cpan/authors/id/C/CA/CAPTTOFU/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 s390 sh sparc x86"

IUSE=""

DEPEND="dev-perl/DBI
	dev-db/mysql"

mydoc="ToDo"
