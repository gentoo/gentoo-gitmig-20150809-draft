# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/cvsroot/gentoo-x86/app-misc/gkrellm-volume-0.8.ebuild,v 1.0 
# 26 Apr 2001 21:30 CST blutgens Exp $

MY_P=${PN/gkrellm-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A mixer control plugin for gkrellm"
SRC_URI="http://gkrellm.luon.net/files/${MY_P}-${PV}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/volume.phtml"

DEPEND="=app-admin/gkrellm-1.2*"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/gkrellm/plugins
	doins volume.so
	dodoc README Changelog
}
