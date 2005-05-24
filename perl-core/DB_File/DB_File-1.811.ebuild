# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/DB_File/DB_File-1.811.ebuild,v 1.1 2005/05/24 14:37:15 mcummings Exp $

inherit perl-module

DESCRIPTION="A Berkeley DB Support Perl Module"
HOMEPAGE="http://www.cpan.org/modules/by-module/DB_File/${P}.readme"
SRC_URI="mirror://cpan/authors/id/P/PM/PMQS/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="sys-libs/db"

SRC_TEST="do"

mydoc="Changes"
