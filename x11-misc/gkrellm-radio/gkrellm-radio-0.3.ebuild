# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Seemant Kulleen <seemant@rocketmail.com>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellm-radio/gkrellm-radio-0.3.ebuild,v 1.4 2002/07/08 21:31:06 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GKrellM plugin to control radio tuners"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/gkrellm-radio.phtml"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=app-admin/gkrellm-1.0.6
	=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.9.10-r1"


src_compile() {
	make || die
}

src_install () {
	exeinto /usr/lib/gkrellm/plugins
	doexe radio.so
	dodoc README Changelog
}
