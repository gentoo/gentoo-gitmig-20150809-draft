# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/tinyerp-client/tinyerp-client-4.0.2.ebuild,v 1.2 2007/02/03 04:16:40 beandog Exp $

inherit distutils eutils

DESCRIPTION="Open Source ERP & CRM client"
HOMEPAGE="http://tinyerp.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	>=dev-python/pygtk-2.6"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-setup.patch

	sed -i -e "s@\('path.share':\).*@\1 '/usr/share/tinyerp-client/',@" \
		-e "s@\('path.pixmaps':\).*@\1 '/usr/share/tinyerp-client/',@" \
		bin/options.py
}

src_install() {
	distutils_src_install

	keepdir /usr/share/${PN}/themes
}
