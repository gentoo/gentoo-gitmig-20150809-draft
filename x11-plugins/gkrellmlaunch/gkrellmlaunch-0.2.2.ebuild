# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmlaunch/gkrellmlaunch-0.2.2.ebuild,v 1.2 2002/08/30 05:14:58 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a Program-Launcher Plugin for Gkrellm"
SRC_URI="mirror://sourceforge/gkrellmlaunch/${P}.tar.gz"
HOMEPAGE="http://gkrellmlaunch.sourceforge.net/"

DEPEND="=app-admin/gkrellm-1.2*"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	make || die
}

src_install () {
	exeinto /usr/lib/gkrellm/plugins
	doexe gkrellmlaunch.so

	dodoc README  
}
