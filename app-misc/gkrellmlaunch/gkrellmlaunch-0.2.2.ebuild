# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Jerry A! <jerry@thehutt.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/gkrellmlaunch/gkrellmlaunch-0.2.2.ebuild,v 1.1 2001/12/12 04:33:21 jerrya Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a Program-Launcher Plugin for Gkrellm"
SRC_URI="http://prdownloads.sourceforge.net/gkrellmlaunch/${P}.tar.gz"

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
