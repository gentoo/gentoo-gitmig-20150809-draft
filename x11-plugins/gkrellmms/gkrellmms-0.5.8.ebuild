# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmms/gkrellmms-0.5.8.ebuild,v 1.4 2003/07/16 16:36:12 mholzer Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A sweet plugin to controll xmms from gkrellm"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/gkrellmms.phtml"

DEPEND=">=app-admin/gkrellm-1.2*
	media-sound/xmms"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc "

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/lib/gkrellm/plugins
	doexe gkrellmms.so
	dodoc README Changelog FAQ Themes
}
