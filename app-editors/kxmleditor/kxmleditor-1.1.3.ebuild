# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kxmleditor/kxmleditor-1.1.3.ebuild,v 1.5 2004/12/07 20:18:28 carlo Exp $

inherit kde eutils

DESCRIPTION="KDE XML Editor to display and edit contents of XML files"
HOMEPAGE="http://kxmleditor.sourceforge.net"
SRC_URI="mirror://sourceforge/kxmleditor/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64 sparc"
IUSE=""

need-kde 3.1

src_unpack() {
	kde_src_unpack
	! useq arts && epatch ${FILESDIR}/${P}-configure.patch
}
