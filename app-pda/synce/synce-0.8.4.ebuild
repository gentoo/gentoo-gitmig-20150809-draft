# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce/synce-0.8.4.ebuild,v 1.1 2003/09/02 19:40:09 liquidx Exp $

DESCRIPTION="Synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE="gnome"

DEPEND=">=app-pda/synce-libsynce-0.8.1
	>=app-pda/synce-librapi2-0.8.1
	>=app-pda/synce-dccm-0.8
	>=app-pda/synce-serial-0.8
	
	gnome? ( >=app-pda/synce-gnomevfs-0.8
			>=app-pda/synce-trayicon-0.8 )"
# seems to be required for synce-rra and synce-multisync_plugin
# which we don't have in portage yet
# >=dev-libs/libmimedir-0.3

src_compile() {
	return
}

