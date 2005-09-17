# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkwebmon/gkwebmon-0.2.ebuild,v 1.6 2005/09/17 10:09:42 agriffis Exp $

IUSE=""
DESCRIPTION="A web monitor plugin for GKrellM2"
HOMEPAGE="http://gkwebmon.sourceforge.net/"
SRC_URI="mirror://sourceforge/gkwebmon/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ppc ~sparc x86"

DEPEND="=app-admin/gkrellm-2*"

src_compile() {
	make || die
}

src_install() {
	insinto /usr/lib/gkrellm2/plugins
	doins gkwebmon.so
}
