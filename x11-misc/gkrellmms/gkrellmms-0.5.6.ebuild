# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>, updated for new Gkrellm by Seemant
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellmms/gkrellmms-0.5.6.ebuild,v 1.2 2002/06/12 03:23:50 lamer Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A sweet plugin to controll xmms from gkrellm"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/gkrellm/Plugins.html"

DEPEND=">=app-admin/gkrellm-1.2.9
		>=media-sound/xmms-1.2.4"


src_compile() {
	
	emake || die

}

src_install () {

	exeinto /usr/lib/gkrellm/plugins
	doexe gkrellmms.so
	dodoc README Changelog FAQ Themes
}
