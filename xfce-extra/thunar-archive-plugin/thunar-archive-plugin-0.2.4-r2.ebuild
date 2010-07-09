# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-archive-plugin/thunar-archive-plugin-0.2.4-r2.ebuild,v 1.4 2010/07/09 16:55:04 ssuominen Exp $

EAPI=2
inherit xfconf

DESCRIPTION="Thunar archive plugin"
HOMEPAGE="http://www.foo-projects.org/~benny/projects/thunar-archive-plugin"
SRC_URI="mirror://xfce/src/thunar-plugins/${PN}/0.2/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug"

COMMON_DEPEND="<xfce-base/thunar-1.1.0"
RDEPEND="${COMMON_DEPEND}
	|| ( app-arch/xarchiver
		kde-base/ark
		app-arch/file-roller
		app-arch/squeeze )"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		$(xfconf_use_debug)"
	DOCS="AUTHORS ChangeLog NEWS README THANKS"
	PATCHES=( "${FILESDIR}/${P}-7zlzmaxz.patch" )
}
