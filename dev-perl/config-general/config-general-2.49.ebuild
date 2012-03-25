# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/config-general/config-general-2.49.ebuild,v 1.7 2012/03/25 17:28:46 armin76 Exp $

EAPI=2

MODULE_AUTHOR=TLINDEN
MY_PN=Config-General
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Config file parser module"

SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""

SRC_TEST="do"
