# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellm-console/gkrellm-console-0.1.ebuild,v 1.6 2002/08/02 17:54:50 seemant Exp $

MY_P=consolewatch-0.1
S=${WORKDIR}/${MY_P}
DESCRIPTION="A GKrellM plugin that shows the users logged into each console"
SRC_URI="http://gkrellm.luon.net/files/${MY_P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/consolewatch.phtml"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=app-admin/gkrellm-1.0.6
	        =x11-libs/gtk+-1.2*
	        >=media-libs/imlib-1.9.10-r1"

src_compile() {
	emake || die
}

src_install () {
	insinto /usr/lib/gkrellm/plugins
	doins consolewatch.so
	dodoc README Changelog TODO
}
