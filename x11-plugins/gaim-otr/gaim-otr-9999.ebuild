# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-otr/gaim-otr-9999.ebuild,v 1.1 2007/08/22 03:32:33 tester Exp $

DESCRIPTION="(OTR) Messaging allows you to have private conversations over instant messaging"
HOMEPAGE="http://www.cypherpunks.ca/otr/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="x11-plugins/pidgin-otr"

pkg_postinst() {
	ewarn "As part of the renaming of Gaim into Pidgin, this package has"
	ewarn "been renamed x11-plugins/pidgin-otr. It is being installed now,"
	ewarn "afterwards, you can emerge --unmerge ${CATEGORY}/${P}"
	ewarn "You may also need to add pidgin-otr to your world file by doing:"
	ewarn "emerge -n x11-plugins/pidgin-otr"
}
