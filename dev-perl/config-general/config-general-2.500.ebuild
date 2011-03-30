# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/config-general/config-general-2.500.ebuild,v 1.2 2011/03/30 13:17:14 xmw Exp $

EAPI=3

MY_PN=Config-General
MODULE_AUTHOR=TLINDEN
MODULE_VERSION=2.50
inherit perl-module

DESCRIPTION="Config file parser module"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"
