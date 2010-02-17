# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Caller/Devel-Caller-2.04.ebuild,v 1.1 2010/02/17 15:20:04 tove Exp $

EAPI=2

MODULE_AUTHOR="RCLAMP"
inherit perl-module

DESCRIPTION="meatier versions of caller"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/PadWalker"
RDEPEND="${DEPEND}"

SRC_TEST=do
