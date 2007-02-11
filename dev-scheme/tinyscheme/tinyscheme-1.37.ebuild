# Copyright 2000-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/tinyscheme/tinyscheme-1.37.ebuild,v 1.2 2007/02/11 10:36:57 mabi Exp $

MY_P=${PN}${PV}
DESCRIPTION="Lightweight scheme interpreter"
HOMEPAGE="http://tinyscheme.sourceforge.net"
SRC_URI="http://tinyscheme.sourceforge.net/${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

src_install() {
	newbin scheme tinyscheme
	dolib libtinyscheme.a libtinyscheme.so
}
