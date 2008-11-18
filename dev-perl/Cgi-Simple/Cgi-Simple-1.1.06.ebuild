# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cgi-Simple/Cgi-Simple-1.1.06.ebuild,v 1.2 2008/11/18 14:30:35 tove Exp $

MODULE_AUTHOR=ANDYA
inherit versionator perl-module

MY_P="CGI-Simple-$(delete_version_separator 2)"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A Simple totally OO CGI interface that is CGI.pm compliant"
SRC_URI="mirror://cpan/authors/id/A/AN/ANDYA/${MY_P}.tar.gz"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	virtual/perl-version"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
