# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce/synce-0.14.ebuild,v 1.2 2009/08/07 01:48:27 mescalinum Exp $

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
		kde? (
			=app-pda/synce-kpm-${synce_PV}*
		)
		gnome? (
			~app-pda/synce-gvfs-0.3
			=app-pda/synce-trayicon-${synce_PV}*
		)
		>=app-arch/unshield-0.6
		!app-pda/synce-gnomevfs
		!app-pda/synce-odccm"

src_compile() {
	return
}
