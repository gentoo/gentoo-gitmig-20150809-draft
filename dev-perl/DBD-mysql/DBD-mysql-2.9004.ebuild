# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-mysql/DBD-mysql-2.9004.ebuild,v 1.1 2004/07/19 03:20:25 esammer Exp $

inherit perl-module

DESCRIPTION="The Perl DBD:mysql Module"
HOMEPAGE="http://cpan.pair.com/modules/by-module/DBD/"
SRC_URI="http://cpan.pair.com/authors/id/R/RU/RUDY/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-perl/DBI
	dev-db/mysql"

mydoc="ToDo"
