# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE-XS-Queue-Array/POE-XS-Queue-Array-0.006.ebuild,v 1.2 2009/06/10 01:43:08 robbat2 Exp $

MODULE_AUTHOR="TONYC"

inherit perl-module

DESCRIPTION="an XS implementation of POE::Queue::Array."

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/POE"
RDEPEND="${DEPEND}"

SRC_TEST="do"
