# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Compress-Bzip2/IO-Compress-Bzip2-2.015.ebuild,v 1.3 2008/10/21 16:00:53 keytoaster Exp $

MODULE_AUTHOR=PMQS
inherit perl-module

DESCRIPTION="Read and write bzip2 files/buffers"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 sparc ~x86"
IUSE=""

DEPEND="~dev-perl/Compress-Raw-Bzip2-${PV}
	~dev-perl/IO-Compress-Base-${PV}"

SRC_TEST=do
