# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-mysql/DBD-mysql-2.1027.ebuild,v 1.11 2005/01/20 22:32:07 gustavoz Exp $

inherit perl-module

DESCRIPTION="The Perl DBD:mysql Module"
SRC_URI="http://cpan.pair.com/authors/id/JWIED/${P}.tar.gz"
HOMEPAGE="http://cpan.pair.com/modules/by-module/DBD/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="ia64 x86 amd64 ~ppc sparc ~alpha hppa"
IUSE=""

DEPEND="${DEPEND}
	dev-perl/DBI
	dev-db/mysql"

mydoc="ToDo"
