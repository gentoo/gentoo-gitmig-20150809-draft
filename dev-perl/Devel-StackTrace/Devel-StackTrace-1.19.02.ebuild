# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-StackTrace/Devel-StackTrace-1.19.02.ebuild,v 1.2 2008/11/18 14:45:10 tove Exp $

MODULE_AUTHOR=DROLSKY
inherit perl-module versionator

MY_P=${PN}-$(delete_version_separator 2)
S=${WORKDIR}/${MY_P}

DESCRIPTION="Devel-StackTrace module for perl"
HOMEPAGE="http://search.cpan.org/dist/Devel-StackTrace/"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""
SRC_TEST="do"

RDEPEND="dev-lang/perl
	virtual/perl-File-Spec"
DEPEND=">=virtual/perl-Module-Build-0.28
	${RDEPEND}"

OPTIMIZE="$CFLAGS"
