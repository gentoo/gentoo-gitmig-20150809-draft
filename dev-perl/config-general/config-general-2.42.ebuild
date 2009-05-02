# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/config-general/config-general-2.42.ebuild,v 1.3 2009/05/02 22:44:29 gentoofan23 Exp $

MODULE_AUTHOR=TLINDEN
MY_PN=Config-General
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Config file parser module"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
SRC_TEST="do"
