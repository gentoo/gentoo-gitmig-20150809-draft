# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Number-Format/Number-Format-1.72a.ebuild,v 1.1 2009/05/06 08:11:16 tove Exp $

EAPI=2

MODULE_AUTHOR=WRW
inherit perl-module

DESCRIPTION="Package for formatting numbers for display"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

SRC_TEST="do"
S=${WORKDIR}/${PN}-${PV/a}
