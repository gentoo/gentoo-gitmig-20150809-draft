# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-trayicons/gkrellm-trayicons-1.02.ebuild,v 1.9 2007/02/05 15:58:39 gustavoz Exp $

inherit multilib

DESCRIPTION="Configurable Tray Icons for GKrellM"
HOMEPAGE="http://sweb.cz/tripie/gkrellm/trayicons/"
SRC_URI="http://sweb.cz/tripie/gkrellm/trayicons/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

DEPEND="app-admin/gkrellm"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	insinto /usr/$(get_libdir)/gkrellm2/plugins
	doins trayicons.so
	dodoc AUTHORS LICENSE ChangeLog
}
