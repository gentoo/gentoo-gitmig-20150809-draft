# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <blutgens@gentoo.org>, updated for new Gkrellm by Seemant
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellmms/gkrellmms-0.5.5-r1.ebuild,v 1.1 2002/03/12 12:36:17 seemant Exp $

NP=gkrellmms
S=${WORKDIR}/${NP}
DESCRIPTION="A sweet plugin to controll xmms from gkrellm"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"
#http://web.wt.net/~billw/gkrellm/Plugins/gkrellmms-patch-0.5.5"
HOMEPAGE="http://gkrellm.luon.net/gkrellm/Plugins.html"

DEPEND=">=app-admin/gkrellm-1.2.5
        >=media-sound/xmms-1.2.4"


src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${NP}-patch-0.5.5 || die
}

src_compile() {
	
	emake || die

}

src_install () {

    exeinto /usr/lib/gkrellm/plugins
    doexe gkrellmms.so
    dodoc README ChangeLog FAQ Themes
}
