# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-mysql/DBD-mysql-2.1027.ebuild,v 1.1 2003/06/07 13:29:42 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The Perl DBD:mysql Module"
SRC_URI="http://cpan.pair.com/authors/id/JWIED/${P}.tar.gz"
HOMEPAGE="http://cpan.pair.com/modules/by-module/DBD/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~arm"

DEPEND="${DEPEND}
	dev-perl/DBI
	dev-db/mysql"

mydoc="ToDo"

