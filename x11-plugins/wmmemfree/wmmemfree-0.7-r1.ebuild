# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmemfree/wmmemfree-0.7-r1.ebuild,v 1.9 2008/01/15 08:11:47 drac Exp $

inherit eutils toolchain-funcs

DESCRIPTION="a blue memory monitoring dockapp."
HOMEPAGE="http://misuceldestept.go.ro/wmmemfree"
SRC_URI="http://ibiblio.org/pub/linux/X11/xutils/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-add-kernel-26-support.patch
}

src_compile() {
	emake CC="$(tc-getCC)" FLAGS="${CFLAGS}" \
		STRIP="true" || die "emake failed."
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc ChangeLog README THANKS TODO WMS
}
