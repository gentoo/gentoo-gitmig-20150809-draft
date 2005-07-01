# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/module-rebuild/module-rebuild-0.4.ebuild,v 1.2 2005/07/01 09:59:39 dholm Exp $

DESCRIPTION="A utility to rebuild any kernel modules which you have installed."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""

src_install() {
	newsbin ${FILESDIR}/${P} ${PN}
}

