# Copyright 1999-2012 Sabayon Promotion
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kcm-grub2/kcm-grub2-0.5.0.ebuild,v 1.2 2012/01/10 13:09:12 johu Exp $

EAPI=4

KDE_MINIMAL="4.6"
KDE_LINGUAS="da de et hu nl pt pt_BR sv uk"
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

PATCHES=(
	"${FILESDIR}"/${PN}-use-gentoo-grub-commands.patch
)

src_configure() {
	local mycmakeargs=(
		"-DWITHQApt=OFF"
		$(cmake-utils_use_with packagekit QPackageKit)
		$(cmake-utils_use_with imagemagick ImageMagick)
		$(cmake-utils_use_with hwinfo HD)
	)
	cmake-utils_src_configure
}
