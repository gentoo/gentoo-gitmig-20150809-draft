# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-cdb/python-cdb-0.32.ebuild,v 1.10 2006/01/24 15:00:50 weeve Exp $

inherit distutils

DESCRIPTION="A Python extension module for cdb"
SRC_URI="http://pilcrow.madison.wi.us/python-cdb/${P}.tar.gz"
HOMEPAGE="http://pilcrow.madison.wi.us/#pycdb"

SLOT="0"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~ppc-macos sparc x86"

DEPEND=">=dev-lang/python-2.2
	dev-db/cdb"
