# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/matwm2/matwm2-0.0.96.ebuild,v 1.1 2010/01/04 14:52:50 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Simple EWMH compatible window manager with titlebars and frames"
HOMEPAGE="http://www.gatorgitter.com/~maties/"
SRC_URI="http://www.gatorgitter.com/~maties/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin ${PN} || die
	doman ${PN}.1
	dodoc BUGS ChangeLog default_matwmrc README TODO

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/${PN}.desktop || die

	echo ${PN} > "${T}"/${PN}
	exeinto /etc/X11/Sessions
	doexe "${T}"/${PN} || die
}
