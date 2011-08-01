# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AnyEvent-I3/AnyEvent-I3-0.70.0.ebuild,v 1.1 2011/08/01 06:16:16 xarthisius Exp $

EAPI=3

MODULE_VERSION=0.07
MODULE_AUTHOR=MSTPLBG
inherit perl-module

DESCRIPTION="communicate with the i3 window manager"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="
	dev-perl/AnyEvent
	dev-perl/JSON-XS
"
DEPEND="
	${COMMON_DEPEND}
"
RDEPEND="
	${COMMON_DEPEND}
"
SRC_TEST="do"
