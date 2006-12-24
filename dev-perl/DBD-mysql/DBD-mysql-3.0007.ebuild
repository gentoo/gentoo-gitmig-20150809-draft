# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-mysql/DBD-mysql-3.0007.ebuild,v 1.9 2006/12/24 00:45:35 dertobi123 Exp $

inherit eutils perl-module

DESCRIPTION="The Perl DBD:mysql Module"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/C/CA/CAPTTOFU/"
SRC_URI="mirror://cpan/authors/id/C/CA/CAPTTOFU/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ia64 ~mips ppc ~ppc64 s390 sh sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/DBI
	virtual/mysql"

mydoc="ToDo"
