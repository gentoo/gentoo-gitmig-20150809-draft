# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libhx/libhx-3.5.ebuild,v 1.4 2010/09/12 13:52:37 josejx Exp $

EAPI=3

inherit eutils

DESCRIPTION="Platform independent library providing basic system functions."
HOMEPAGE="http://libhx.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/libHX-${PV}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="app-arch/xz-utils"
RDEPEND=""

S="${WORKDIR}/libHX-${PV}"

src_prepare() {
	epatch "${FILESDIR}/${P}-buffer-overflow.patch"
}

src_configure() {
	econf --docdir="/usr/share/doc/${PF}" || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc doc/*.txt || die
}
