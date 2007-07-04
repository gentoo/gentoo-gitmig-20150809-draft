# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-lzo/python-lzo-1.08.ebuild,v 1.2 2007/07/04 21:43:17 hawking Exp $

inherit eutils distutils

DESCRIPTION="Python interface to lzo"
SRC_URI="http://www.oberhumer.com/opensource/lzo/download/LZO-v1/${P}.tar.gz"
HOMEPAGE="http://www.oberhumer.com/opensource/lzo/"
RDEPEND="virtual/python
		dev-libs/lzo"
DEPEND="${RDEPEND}"
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
	if has_version ">=dev-libs/lzo-2"; then
		epatch "${FILESDIR}"/lzo2compat.patch
	fi
}
