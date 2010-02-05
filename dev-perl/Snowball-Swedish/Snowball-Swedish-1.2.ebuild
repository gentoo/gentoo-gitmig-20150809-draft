# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Snowball-Swedish/Snowball-Swedish-1.2.ebuild,v 1.9 2010/02/05 22:22:25 tove Exp $

EAPI=2

MODULE_AUTHOR=ASKSH
inherit perl-module

DESCRIPTION="Porters stemming algorithm for Swedish"

SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
