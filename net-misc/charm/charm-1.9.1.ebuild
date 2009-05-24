# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/charm/charm-1.9.1.ebuild,v 1.1 2009/05/24 04:03:09 neurogeek Exp $

EAPI="2"
NEED_PYTHON=2.5

inherit distutils

DESCRIPTION="A text based livejournal client"
HOMEPAGE="http://ljcharm.sourceforge.net/"
SRC_URI="mirror://sourceforge/ljcharm/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

src_prepare() {
	sed -i \
		-e 's/("share\/doc\/charm", .*),/\\/' \
		setup.py
}

src_install() {
	DOCS="CHANGES.charm sample.charmrc README.charm"
	distutils_src_install
	dohtml charm.html || die "Could not install charm.html"
}

pkg_postinst() {
	elog "You need to create a ~/.charmrc before running charm."
	elog "Read 'man charmrc' for more information."
	elog ""
}
