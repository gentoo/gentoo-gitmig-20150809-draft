# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-mailwatch/gkrellm-mailwatch-0.7.2.ebuild,v 1.7 2004/03/26 23:10:05 aliz Exp $

IUSE=""
MY_P=${P/gkrellm-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A GKrellM plugin that shows the status of additional mail boxes"
SRC_URI="http://gkrellm.luon.net/files/${MY_P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/mailwatch.phtml"

DEPEND="=app-admin/gkrellm-1.2*
	>=media-libs/imlib-1.9.10-r1"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

src_compile() {
	make || die
}

src_install () {
	exeinto /usr/lib/gkrellm/plugins
	doexe mailwatch.so
	dodoc README Changelog TODO
}
