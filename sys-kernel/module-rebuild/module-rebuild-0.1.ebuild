# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/module-rebuild/module-rebuild-0.1.ebuild,v 1.1 2005/05/03 22:53:37 johnm Exp $

DESCRIPTION="A utility to rebuild any kernel modules which you have installed."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	newsbin ${FILESDIR}/${P} ${PN}
}

