# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/colubrid/colubrid-0.10-r1.ebuild,v 1.1 2008/03/18 13:17:13 antarus Exp $

inherit distutils

DESCRIPTION="Colubrid is a set of tools around the WSGI standard."
HOMEPAGE="http://wsgiarea.pocoo.org/colubrid/"
MY_P="Colubrid-${PV}"
SRC_URI="http://wsgiarea.pocoo.org/colubrid/dist/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND=""
RDEPEND=""
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack $A
	cd "$S"
	epatch "${FILESDIR}"/${P}.patch
}
