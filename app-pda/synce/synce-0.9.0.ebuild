# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce/synce-0.9.0.ebuild,v 1.2 2004/10/18 12:17:12 dholm Exp $

DESCRIPTION="Synchronize Windows CE devices with Linux."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="gnome kde"

DEPEND=">=app-pda/synce-libsynce-0.9.0
	>=app-pda/synce-librapi2-0.9.0
	>=app-pda/synce-dccm-0.9.0
	>=app-pda/synce-serial-0.9.0
	>=app-pda/orange-0.2
	>=app-arch/unshield-0.4
	gnome? ( >=app-pda/synce-gnomevfs-0.9.0
		>=app-pda/synce-trayicon-0.9.0
		>=app-pda/synce-software-manager-0.9.0 )
	kde? ( >=app-pda/synce-kde-0.8 )"

src_compile() {
	return
}

