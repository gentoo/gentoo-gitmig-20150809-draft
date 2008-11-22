# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unicode-MapUTF8/Unicode-MapUTF8-1.11.ebuild,v 1.23 2008/11/22 11:30:59 tove Exp $

MODULE_AUTHOR=SNOWHARE
inherit perl-module

DESCRIPTION="Conversions to and from arbitrary character sets and UTF8"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="dev-perl/Unicode-Map
	dev-perl/Unicode-Map8
	dev-perl/Unicode-String
	dev-perl/Jcode
	dev-lang/perl"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
