# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libhx/libhx-3.14.ebuild,v 1.1 2012/11/30 09:59:18 scarabeus Exp $

EAPI=5

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
	prune_libtool_files --all
}
