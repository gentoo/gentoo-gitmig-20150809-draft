# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OLE-StorageLite/OLE-StorageLite-0.17.ebuild,v 1.1 2008/10/31 08:54:42 tove Exp $

MODULE_AUTHOR=JMCNAMARA
MY_PN=OLE-Storage_Lite
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Simple Class for OLE document interface."
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
