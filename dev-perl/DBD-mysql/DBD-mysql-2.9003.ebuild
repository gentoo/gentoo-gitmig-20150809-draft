# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-mysql/DBD-mysql-2.9003.ebuild,v 1.5 2004/04/02 15:29:35 randy Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The Perl DBD:mysql Module"
SRC_URI="http://cpan.pair.com/authors/id/R/RU/RUDY/${P}.tar.gz"
HOMEPAGE="http://cpan.pair.com/modules/by-module/DBD/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~ia64 ~x86 ~amd64 ~ppc ~sparc ~alpha hppa mips s390"

DEPEND="${DEPEND}
	dev-perl/DBI
	dev-db/mysql"

mydoc="ToDo"

