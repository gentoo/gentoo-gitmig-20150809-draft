# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmms/gkrellmms-0.5.6.ebuild,v 1.3 2002/09/12 04:54:12 owen Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A sweet plugin to controll xmms from gkrellm"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/gkrellm/Plugins.html"

DEPEND=">=app-admin/gkrellm-1.2*
	=media-sound/xmms-1.2*"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/lib/gkrellm/plugins
	doexe gkrellmms.so
	dodoc README Changelog FAQ Themes
}
