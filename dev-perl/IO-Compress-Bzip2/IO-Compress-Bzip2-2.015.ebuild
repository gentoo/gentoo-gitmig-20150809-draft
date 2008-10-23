# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Compress-Bzip2/IO-Compress-Bzip2-2.015.ebuild,v 1.7 2008/10/23 18:18:00 dertobi123 Exp $

MODULE_AUTHOR=PMQS
inherit perl-module

DESCRIPTION="Read and write bzip2 files/buffers"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="~dev-perl/Compress-Raw-Bzip2-${PV}
	~dev-perl/IO-Compress-Base-${PV}"

SRC_TEST=do
