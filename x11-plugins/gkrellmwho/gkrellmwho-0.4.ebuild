# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmwho/gkrellmwho-0.4.ebuild,v 1.3 2002/09/12 05:02:32 owen Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GKrellM plugin which displays users logged in"
SRC_URI="http://web.wt.net/~billw/gkrellm/Plugins/${P}.tar.gz"
HOMEPAGE="http://web.wt.net/~billw/gkrellm/Plugins"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="=app-admin/gkrellm-1.2*"

src_compile() {
	emake || die
}

src_install () {
	insinto /usr/lib/gkrellm/plugins
	doins gkrellmwho.so
	dodoc README 
}
