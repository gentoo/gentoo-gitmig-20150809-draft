# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pystatgrab/pystatgrab-0.3.ebuild,v 1.7 2008/05/19 17:14:15 drac Exp $

inherit distutils

DESCRIPTION=" pystatgrab is a set of Python bindings for the libstatgrab library."
HOMEPAGE="http://www.i-scream.org/pystatgrab/"
SRC_URI="http://www.mirrorservice.org/sites/ftp.i-scream.org/pub/i-scream/pystatgrab/${P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"

RDEPEND="virtual/python
	>=sys-libs/libstatgrab-0.9
	!>=sys-libs/libstatgrab-0.12"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
