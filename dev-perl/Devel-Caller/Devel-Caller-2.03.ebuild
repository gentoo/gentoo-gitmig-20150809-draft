# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Caller/Devel-Caller-2.03.ebuild,v 1.1 2009/06/23 07:38:32 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="RCLAMP"

inherit perl-module

DESCRIPTION="meatier versions of caller"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/PadWalker"
RDEPEND="${DEPEND}"
