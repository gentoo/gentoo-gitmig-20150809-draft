# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmms/gkrellmms-2.1.12.ebuild,v 1.5 2004/01/09 15:50:24 agriffis Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A sweet plugin to control XMMS from GKrellM2"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/gkrellmms.phtml"

DEPEND=">=app-admin/gkrellm-2*
	media-sound/xmms"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc alpha"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/lib/gkrellm2/plugins
	newexe gkrellmms.so gkrellmms2.so
	dodoc README Changelog FAQ Themes
}
