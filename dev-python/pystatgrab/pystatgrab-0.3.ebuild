# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pystatgrab/pystatgrab-0.3.ebuild,v 1.2 2005/04/24 13:11:31 hansmi Exp $

inherit distutils

DESCRIPTION=" pystatgrab is a set of Python bindings for the libstatgrab library."
HOMEPAGE="http://www.i-scream.org/pystatgrab/"
SRC_URI="http://www.mirrorservice.org/sites/ftp.i-scream.org/pub/i-scream/pystatgrab/${P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/python
	>=sys-libs/libstatgrab-0.9"

