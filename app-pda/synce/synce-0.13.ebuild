# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce/synce-0.13.ebuild,v 1.3 2009/01/21 11:50:23 mescalinum Exp $

inherit versionator

DESCRIPTION="Synchronize Windows CE devices with Linux."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI=""

synce_PV=$(get_version_component_range 1-2)

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gnome hal kde serial"
DEPEND=""
RDEPEND="=app-pda/synce-sync-engine-${synce_PV}*
		hal? (
			=app-pda/synce-hal-${synce_PV}*
		)
		!hal? (
			=app-pda/synce-odccm-${synce_PV}*
		)
		kde? (
			=app-pda/synce-kpm-${synce_PV}*
		)
		gnome? (
			~app-pda/synce-gvfs-0.2.1
			=app-pda/synce-trayicon-${synce_PV}*
		)"

src_compile() {
	return
}
