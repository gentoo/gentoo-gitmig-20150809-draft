# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-archive-plugin/thunar-archive-plugin-0.2.4-r2.ebuild,v 1.13 2010/12/25 07:47:16 ssuominen Exp $

EAPI=3
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="Archive plug-in for Thunar, filemanager of the Xfce desktop environment"
HOMEPAGE="http://goodies.xfce.org/projects/thunar-plugins/thunar-archive-plugin"
SRC_URI="mirror://xfce/src/thunar-plugins/${PN}/0.2/${P}.tar.bz2
	mirror://gentoo/${PN}-0.2.4-thunarx-2.patch.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug"

COMMON_DEPEND="xfce-base/thunar"
RDEPEND="${COMMON_DEPEND}
	|| ( app-arch/xarchiver app-arch/file-roller kde-base/ark app-arch/squeeze )"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
	dev-util/pkgconfig"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-7zlzmaxz.patch )

	if has_version ">=xfce-base/thunar-1.1.0"; then
		PATCHES+=( "${WORKDIR}"/${PN}-0.2.4-thunarx-2.patch )
	fi

	XFCONF=(
		--disable-dependency-tracking
		$(xfconf_use_debug)
		)

	DOCS="AUTHORS ChangeLog NEWS README THANKS"
}
