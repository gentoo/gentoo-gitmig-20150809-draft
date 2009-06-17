# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kxmleditor/kxmleditor-1.1.4-r1.ebuild,v 1.4 2009/06/17 13:18:02 fauli Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="KDE XML Editor to display and edit contents of XML files"
HOMEPAGE="http://kxmleditor.sourceforge.net"
SRC_URI="mirror://sourceforge/kxmleditor/${P}.tar.gz"

SLOT="3.5"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

need-kde 3.5

PATCHES=(
	"${FILESDIR}/kxmleditor-1.1.4-desktop-file.diff"
	)

src_unpack() {
	kde_src_unpack
	rm -f "${S}"/configure
}
