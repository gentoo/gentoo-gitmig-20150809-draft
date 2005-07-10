# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmms/gkrellmms-2.1.22.ebuild,v 1.2 2005/07/10 19:55:59 swegener Exp $

inherit multilib

S=${WORKDIR}/${PN}
DESCRIPTION="A sweet plugin to control XMMS from GKrellM2"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/gkrellmms.phtml"
IUSE="bmp"
DEPEND=">=app-admin/gkrellm-2
	!bmp? ( media-sound/xmms )
	bmp? ( media-sound/beep-media-player )"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"

src_compile() {
	if useq bmp; then
		emake USE_BMP="1" || die
	else
		emake || die
	fi
}

src_install () {
	exeinto /usr/$(get_libdir)/gkrellm2/plugins
	newexe gkrellmms.so gkrellmms2.so
	dodoc README Changelog FAQ Themes
}
