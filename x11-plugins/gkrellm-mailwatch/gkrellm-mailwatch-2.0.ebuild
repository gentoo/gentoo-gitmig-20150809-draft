# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-mailwatch/gkrellm-mailwatch-2.0.ebuild,v 1.1 2002/10/16 21:19:33 seemant Exp $ 

S=${WORKDIR}/${PN}
DESCRIPTION="A GKrellM2 plugin that shows the status of additional mail boxes"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/mailwatch.phtml"

DEPEND="=app-admin/gkrellm-2.0*
	>=media-libs/imlib-1.9.14-r1"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/lib/gkrellm2/plugins
	doexe mailwatch.so
	dodoc README Changelog TODO
}
