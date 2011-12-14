# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libhx/libhx-3.12.ebuild,v 1.1 2011/12/14 20:44:17 mattst88 Exp $

EAPI=4

DESCRIPTION="Platform independent library providing basic system functions."
HOMEPAGE="http://libhx.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/libHX-${PV}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="app-arch/xz-utils"
RDEPEND=""

S="${WORKDIR}/libHX-${PV}"

src_configure() {
	econf --docdir="/usr/share/doc/${PF}"
}

src_install() {
	default
	dodoc doc/*.txt
	find "${D}" -name '*.la' -delete
}
