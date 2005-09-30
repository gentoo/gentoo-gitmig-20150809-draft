# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-mysql/DBD-mysql-2.9006.ebuild,v 1.2 2005/09/30 21:54:45 matsuu Exp $

inherit perl-module

DESCRIPTION="The Perl DBD:mysql Module"
HOMEPAGE="http://search.cpan.org/~rudy/${P}/"
SRC_URI="mirror://cpan/authors/id/R/RU/RUDY/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc ~mips ~alpha ~arm ~hppa ~ia64 ~s390 ~sh ~ppc64"

IUSE=""

DEPEND="dev-perl/DBI
	dev-db/mysql"

mydoc="ToDo"
