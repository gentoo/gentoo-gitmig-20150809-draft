# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/partitionmanager/partitionmanager-1.0.3.ebuild,v 1.2 2011/01/11 22:01:27 maekke Exp $

EAPI="2"

KDE_LINGUAS="bg ca da de el en_GB es et fr gl ja lt nb nds nl nn pa pl pt
pt_BR ro ru sv tr uk zh_CN zh_TW"

KMNAME="extragear/sysadmin"
inherit kde4-base

DESCRIPTION="KDE utility for management of partitions and file systems."
HOMEPAGE="http://partitionman.sourceforge.net/"
SRC_URI="mirror://sourceforge/partitionman/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	sys-block/parted
	sys-libs/e2fsprogs-libs
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DPARTMAN_KPART=ON
		-DPARTMAN_KCM=ON
	"

	kde4-base_src_configure
}
