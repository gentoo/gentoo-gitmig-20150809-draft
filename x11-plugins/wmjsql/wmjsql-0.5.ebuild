# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmjsql/wmjsql-0.5.ebuild,v 1.12 2010/07/22 14:32:07 ssuominen Exp $

IUSE=""

MY_P="${PN}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="MySQL monitor dockapp"
SRC_URI="http://www.dockapps.org/download.php/id/73/${P}.tar.gz"
HOMEPAGE="http://www.dockapps.org/file.php/id/42"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto
	>=virtual/mysql-4.0"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc sparc x86"

src_compile() {
	cd "${S}"/src
	make clean
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	cd "${S}"/src
	dobin wmjsql || die
	newdoc conf sample.wmjsql

	cd "${S}"
	dodoc CREDITS README TODO

	insinto /usr/share/applications
	doins "${FILESDIR}"/${PN}.desktop
}
