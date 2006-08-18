# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmms/gkrellmms-2.1.22.ebuild,v 1.4 2006/08/18 16:02:12 dertobi123 Exp $

inherit multilib

S=${WORKDIR}/${PN}
DESCRIPTION="A sweet plugin to control XMMS from GKrellM2"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/gkrellmms.phtml"
IUSE=""
DEPEND=">=app-admin/gkrellm-2
	media-sound/xmms"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ppc ~sparc ~x86"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/$(get_libdir)/gkrellm2/plugins
	newexe gkrellmms.so gkrellmms2.so
	dodoc README Changelog FAQ Themes
}
