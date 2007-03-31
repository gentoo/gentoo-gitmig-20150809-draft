# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-mysql/DBD-mysql-4.00.4-r1.ebuild,v 1.1 2007/03/31 12:39:36 mcummings Exp $

inherit eutils perl-module versionator


MY_PV="$(delete_version_separator 2)"
MY_P="${PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="The Perl DBD:mysql Module"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/C/CA/CAPTTOFU/"
SRC_URI="mirror://cpan/authors/id/C/CA/CAPTTOFU/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""
PATCHES="${FILESDIR}/sqlstate-purge.patch"

DEPEND="dev-lang/perl
	dev-perl/DBI
	virtual/mysql"

mydoc="ToDo"
