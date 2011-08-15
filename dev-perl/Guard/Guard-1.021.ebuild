# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Guard/Guard-1.021.ebuild,v 1.1 2011/08/15 14:11:26 patrick Exp $

EAPI=3

MODULE_AUTHOR="MLEHMANN"
inherit perl-module

DESCRIPTION="Safe cleanup blocks."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

SRC_TEST="do"
