# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmlaunch/gkrellmlaunch-0.3.ebuild,v 1.4 2002/10/04 06:45:17 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a Program-Launcher Plugin for GKrellM"
SRC_URI="mirror://sourceforge/gkrellmlaunch/${P}.tar.gz"
HOMEPAGE="http://gkrellmlaunch.sourceforge.net/"

DEPEND="=app-admin/gkrellm-1.2*"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/gkrellm/plugins
	doins gkrellmlaunch.so

	dodoc README  
}
