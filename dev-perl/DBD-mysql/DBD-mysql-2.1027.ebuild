# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-mysql/DBD-mysql-2.1027.ebuild,v 1.13 2006/07/04 07:17:34 ian Exp $

inherit perl-module

DESCRIPTION="The Perl DBD:mysql Module"
SRC_URI="http://cpan.pair.com/authors/id/JWIED/${P}.tar.gz"
HOMEPAGE="http://cpan.pair.com/modules/by-module/DBD/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="ia64 x86 amd64 ppc sparc ~alpha hppa"
IUSE=""

DEPEND="dev-perl/DBI
	dev-db/mysql"
RDEPEND="${DEPEND}"

mydoc="ToDo"