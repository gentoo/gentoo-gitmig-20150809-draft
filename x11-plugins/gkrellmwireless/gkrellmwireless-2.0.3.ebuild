# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmwireless/gkrellmwireless-2.0.3.ebuild,v 1.9 2007/03/08 14:04:53 lack Exp $

inherit multilib

IUSE=""
S=${WORKDIR}/${PN}
DESCRIPTION="A plugin for GKrellM that monitors your wireless network card"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~sparc x86"

DEPEND="=app-admin/gkrellm-2*"

src_compile() {
	if ! built_with_use app-admin/gkrellm X; then
		eerror "This plugin requires the X frontend of gkrellm."
		eerror "Please re-emerge app-admin/gkrellm with USE=\"X\""
		die "Plugins need USE=\"X\" in app-admin/gkrellm"
	fi

	export PATH="${PATH}:/usr/X11R6/bin"
	make || die

}

src_install () {
	insinto /usr/$(get_libdir)/gkrellm2/plugins
	doins wireless.so
	dodoc README Changelog
}
