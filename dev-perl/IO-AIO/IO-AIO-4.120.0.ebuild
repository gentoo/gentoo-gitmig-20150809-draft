# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-AIO/IO-AIO-4.120.0.ebuild,v 1.1 2012/03/02 00:01:21 robbat2 Exp $

EAPI=4

MODULE_AUTHOR=MLEHMANN
MODULE_VERSION=4.12
inherit perl-module

DESCRIPTION="Asynchronous Input/Output"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-perl/common-sense"
RDEPEND="${DEPEND}"

SRC_TEST="do"
