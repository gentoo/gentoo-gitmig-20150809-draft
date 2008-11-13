# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce/synce-0.12.ebuild,v 1.1 2008/11/13 16:45:21 mescalinum Exp $

DESCRIPTION="Synchronize Windows CE devices with Linux."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gnome hal kde serial"
DEPEND=""
RDEPEND="~app-pda/synce-sync-engine-0.12
		hal? (
			>=app-pda/synce-hal-0.1
		)
		!hal? (
			~app-pda/synce-odccm-0.12
		)
		serial? (
			~app-pda/synce-serial-0.11
		)
		kde? (
			~app-pda/synce-kio-rapip-0.10
			~app-pda/synce-kpm-0.12
		)
		gnome? (
			~app-pda/synce-gvfs-0.1
			~app-pda/synce-trayicon-0.12
		)"

src_compile() {
	return
}
