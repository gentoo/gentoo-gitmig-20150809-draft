# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-DBI/Apache-DBI-1.08.ebuild,v 1.1 2010/02/04 08:43:53 tove Exp $

EAPI=2

MODULE_AUTHOR=ABH
inherit perl-module

DESCRIPTION="Apache::DBI module for perl"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-perl/Digest-SHA1-2.01
	>=virtual/perl-Digest-MD5-2.2
	>=dev-perl/DBI-1.30"
DEPEND="${RDEPEND}"

export OPTIMIZE="$CFLAGS"
#SRC_TEST="do"
