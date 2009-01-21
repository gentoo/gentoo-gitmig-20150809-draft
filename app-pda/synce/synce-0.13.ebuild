# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce/synce-0.13.ebuild,v 1.1 2009/01/21 01:08:35 mescalinum Exp $

DESCRIPTION="Synchronize Windows CE devices with Linux."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gnome hal kde serial"
DEPEND=""
RDEPEND="~app-pda/synce-sync-engine-${PV}
		hal? (
			>=app-pda/synce-hal-${PV}
		)
		!hal? (
			~app-pda/synce-odccm-${PV}
		)
		kde? (
			~app-pda/synce-kpm-${PV}
		)
		gnome? (
			~app-pda/synce-gvfs-0.2.1
			~app-pda/synce-trayicon-${PV}
		)"

src_compile() {
	return
}
