# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellshoot/gkrellshoot-0.4.1.ebuild,v 1.11 2004/03/26 23:10:05 aliz Exp $

IUSE=""
S=${WORKDIR}/${P/s/S}
DESCRIPTION="GKrellm2 plugin to take screen shots and lock screen"
SRC_URI="mirror://sourceforge/gkrellshoot/${P}.tar.gz"
HOMEPAGE="http://gkrellshoot.sourceforge.net/"

DEPEND=">=app-admin/gkrellm-2*"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~alpha"

src_compile() {

	export CFLAGS="${CFLAGS/-O?/}"

	make || die
}

src_install () {
	insinto /usr/lib/gkrellm2/plugins
	doins gkrellshoot.so
	dodoc README ChangeLog
}
