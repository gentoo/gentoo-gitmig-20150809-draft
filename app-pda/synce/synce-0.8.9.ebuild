# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce/synce-0.8.9.ebuild,v 1.4 2007/07/15 05:41:19 mr_bones_ Exp $

DESCRIPTION="Synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE="gnome"

DEPEND=">=app-pda/synce-libsynce-0.8.9
	>=app-pda/synce-librapi2-0.8.9
	>=app-pda/synce-dccm-0.8.9
	>=app-pda/synce-serial-0.8.9

	gnome? ( >=app-pda/synce-gnomevfs-0.8
			>=app-pda/synce-trayicon-0.8 )
			>=app-pda/orange-0.2"

src_compile() {
	return
}
