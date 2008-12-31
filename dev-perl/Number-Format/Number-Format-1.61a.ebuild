# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Number-Format/Number-Format-1.61a.ebuild,v 1.1 2008/12/31 18:35:24 tove Exp $

MODULE_AUTHOR=WRW
S=${WORKDIR}/${PN}-${PV/a}
inherit perl-module

DESCRIPTION="Package for formatting numbers for display"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
