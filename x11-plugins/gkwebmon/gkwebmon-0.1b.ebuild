# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkwebmon/gkwebmon-0.1b.ebuild,v 1.4 2004/04/30 21:28:43 pvdabeel Exp $

IUSE=""

DESCRIPTION="A web monitor plugin for GKrellM2"
HOMEPAGE="http://gkwebmon.sourceforge.net/"
SRC_URI="mirror://sourceforge/gkwebmon/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc ~alpha"

DEPEND="=app-admin/gkrellm-2*"

src_compile() {
	make || die
}

src_install() {
	insinto /usr/lib/gkrellm2/plugins
	doins gkwebmon.so
}
