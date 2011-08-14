# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libhx/libhx-3.11.ebuild,v 1.1 2011/08/14 18:28:29 hanno Exp $

EAPI=3

inherit eutils

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
	econf --docdir="/usr/share/doc/${PF}" || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc doc/*.txt || die
	find "${D}" -name '*.la' -delete
}
