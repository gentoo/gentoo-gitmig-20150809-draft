# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-trayicons/gkrellm-trayicons-1.02.ebuild,v 1.1 2004/04/20 15:31:22 mholzer Exp $

DESCRIPTION="Configurable Tray Icons for GKrellM"
HOMEPAGE="http://sweb.cz/tripie/gkrellm/trayicons/"
SRC_URI="http://sweb.cz/tripie/gkrellm/trayicons/dist/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="mpeg4"

DEPEND="app-admin/gkrellm"

src_compile() {
	emake || die
}

src_install() {
	insinto /usr/lib/gkrellm2/plugins
	doins trayicons.so
	dodoc AUTHORS LICENSE ChangeLog
}
