# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ark/ark-4.6.3-r1.ebuild,v 1.1 2011/05/08 17:26:39 jmbsvicetto Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE Archiving tool"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+archive +bzip2 debug lzma"

DEPEND="
	$(add_kdebase_dep libkonq)
	sys-libs/zlib
	archive? ( >=app-arch/libarchive-2.6.1[bzip2?,lzma?,zlib] )
	lzma? ( app-arch/xz-utils )
"
RDEPEND="${DEPEND}"

# detect-libarchive patch - https://bugs.kde.org/show_bug.cgi?id=271553
PATCHES=(
	"${FILESDIR}/${PN}-detect-libarchive-in-proper-place.patch"
)

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with archive LibArchive)
		$(cmake-utils_use_with bzip2 BZip2)
		$(cmake-utils_use_with lzma LibLZMA)
	)
	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-meta_pkg_postinst
	elog "For creating rar archives, install app-arch/rar"
}
