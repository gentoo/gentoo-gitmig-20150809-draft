# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Jerry A! <jerry@thehutt.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellmlaunch/gkrellmlaunch-0.2.2.ebuild,v 1.2 2002/05/27 17:27:40 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a Program-Launcher Plugin for Gkrellm"
SRC_URI="mirror://sourceforge/gkrellmlaunch/${P}.tar.gz"

HOMEPAGE="http://gkrellmlaunch.sourceforge.net/"

DEPEND=">=app-admin/gkrellm-1.2.1"


src_compile() {
	make || die
}

src_install () {
	exeinto /usr/lib/gkrellm/plugins
	doexe gkrellmlaunch.so

	dodoc README  
}
