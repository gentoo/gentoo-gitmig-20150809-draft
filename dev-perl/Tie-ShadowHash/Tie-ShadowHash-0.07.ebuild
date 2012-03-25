# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tie-ShadowHash/Tie-ShadowHash-0.07.ebuild,v 1.2 2012/03/25 17:14:45 armin76 Exp $

EAPI=2

MODULE_AUTHOR=RRA
MY_PN=ShadowHash
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Merge multiple data sources into a hash"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

SRC_TEST="do"
