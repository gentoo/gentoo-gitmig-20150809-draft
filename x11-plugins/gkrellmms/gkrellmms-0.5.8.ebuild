# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmms/gkrellmms-0.5.8.ebuild,v 1.11 2005/01/02 02:06:11 mholzer Exp $

IUSE=""
S=${WORKDIR}/${PN}
DESCRIPTION="A sweet plugin to control xmms from gkrellm"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/gkrellmms.phtml"

DEPEND="=app-admin/gkrellm-1.2*
	media-sound/xmms"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/lib/gkrellm/plugins
	doexe gkrellmms.so
	dodoc README Changelog FAQ Themes
}
