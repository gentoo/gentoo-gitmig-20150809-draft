# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-vcs-plugin/thunar-vcs-plugin-0.1.2_p20101105.ebuild,v 1.2 2010/11/05 15:45:30 ssuominen Exp $

# git clone -b thunarx-2 git://git.xfce.org/thunar-plugins/thunar-vcs-plugin

EAPI=3
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="adds Subversion and GIT actions to the context menu of thunar"
HOMEPAGE="http://goodies.xfce.org/projects/thunar-plugins/thunar-vcs-plugin"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug git subversion"

RDEPEND=">=xfce-base/thunar-1.1.0
	>=x11-libs/gtk+-2.6:2
	>=dev-libs/glib-2.6:2
	git? ( dev-vcs/git )
	subversion? ( >=dev-libs/apr-0.9.7
		>=dev-vcs/subversion-1.5 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		$(use_enable subversion)
		$(use_enable git)
		$(xfconf_use_debug)
		)

	DOCS="AUTHORS ChangeLog NEWS README"
}
