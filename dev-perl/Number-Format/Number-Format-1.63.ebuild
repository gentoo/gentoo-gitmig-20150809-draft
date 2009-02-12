# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Number-Format/Number-Format-1.63.ebuild,v 1.1 2009/02/12 11:46:09 tove Exp $

MODULE_AUTHOR=WRW
inherit perl-module

DESCRIPTION="Package for formatting numbers for display"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
