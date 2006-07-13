# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce/synce-0.9.2.ebuild,v 1.1 2006/07/13 21:30:48 liquidx Exp $

DESCRIPTION="Synchronize Windows CE devices with Linux."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE="gnome kde"

DEPEND=">=app-pda/synce-libsynce-0.9.2
	>=app-pda/synce-librapi2-0.9.2
	>=app-pda/synce-dccm-0.9.1
	>=app-pda/synce-serial-0.9.1
	>=app-pda/orange-0.3
	>=app-arch/unshield-0.5
	gnome? ( >=app-pda/synce-gnomevfs-0.9.0
		>=app-pda/synce-trayicon-0.9.0
		>=app-pda/synce-software-manager-0.9.0
		>=app-pda/synce-multisync_plugin-0.9.0 )
	kde? ( >=app-pda/synce-kde-0.8 )"

src_compile() {
	return
}
