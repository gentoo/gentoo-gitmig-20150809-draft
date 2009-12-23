# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/lilo-config/lilo-config-4.3.4.ebuild,v 1.2 2009/12/23 01:13:36 abcd Exp $

EAPI="2"

KMNAME="kdeadmin"
inherit kde4-meta

DESCRIPTION="KDE LiLo kcontrol module"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	sys-boot/lilo
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		-DBUILD_lilo-config=TRUE
		-DLILO_EXECUTABLE=TRUE
	)

	kde4-meta_src_configure
}
