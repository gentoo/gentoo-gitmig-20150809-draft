# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-mysql/DBD-mysql-2.9003.ebuild,v 1.19 2006/07/04 07:17:34 ian Exp $

inherit perl-module

DESCRIPTION="The Perl DBD:mysql Module"
HOMEPAGE="http://cpan.pair.com/modules/by-module/DBD/"
SRC_URI="http://cpan.pair.com/authors/id/R/RU/RUDY/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 s390 sh ppc64"
IUSE=""

DEPEND="dev-perl/DBI
	dev-db/mysql"
RDEPEND="${DEPEND}"

mydoc="ToDo"
