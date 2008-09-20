# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-HomeDir/File-HomeDir-0.80.ebuild,v 1.1 2008/09/20 11:18:39 tove Exp $

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Get home directory for self or other user"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="virtual/perl-File-Spec
	dev-lang/perl"
