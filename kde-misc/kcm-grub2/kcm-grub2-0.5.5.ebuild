# Copyright 1999-2012 Sabayon Promotion
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kcm-grub2/kcm-grub2-0.5.5.ebuild,v 1.3 2012/01/10 14:47:12 johu Exp $

EAPI=4

KDE_LINGUAS="ca cs da de el es et fr ga hu lt nl pa pl pt pt_BR ru sv uk zh_TW"
inherit kde4-base

DESCRIPTION="KCModule for configuring the GRUB2 bootloader."
HOMEPAGE="http://kde-apps.org/content/show.php?content=139643"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-3"

KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="+hwinfo imagemagick packagekit"

COMMON_DEPEND="
	$(add_kdebase_dep kdelibs)
	hwinfo? ( sys-apps/hwinfo )
	imagemagick? ( media-gfx/imagemagick )
	packagekit? ( app-admin/packagekit-qt4 )
"
DEPEND="${COMMON_DEPEND}
	dev-util/automoc
"
RDEPEND="${COMMON_DEPEND}
	$(add_kdebase_dep kcmshell)
"

src_configure() {
	local mycmakeargs=(
		"-DWITHQApt=OFF"
		$(cmake-utils_use_with packagekit QPackageKit)
		$(cmake-utils_use_with imagemagick ImageMagick)
		$(cmake-utils_use_with hwinfo HD)
	)
	cmake-utils_src_configure
}
