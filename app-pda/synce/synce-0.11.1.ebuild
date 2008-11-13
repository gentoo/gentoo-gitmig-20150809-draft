# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce/synce-0.11.1.ebuild,v 1.1 2008/11/13 16:45:21 mescalinum Exp $

DESCRIPTION="Synchronize Windows CE devices with Linux."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gnome serial syncengine"
DEPEND="~app-pda/synce-odccm-0.11.1
		syncengine?	(
			~app-pda/synce-sync-engine-0.11.1
		)
		serial? (
			~app-pda/synce-serial-0.11
		)
		gnome? (
			~app-pda/synce-gnomevfs-0.11.1
			~app-pda/synce-trayicon-0.11
		)"

src_compile() {
	return
}
