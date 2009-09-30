# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-vcs-plugin/thunar-vcs-plugin-0.0.3-r2.ebuild,v 1.1 2009/09/30 08:37:29 ssuominen Exp $

EAPI=2
inherit xfconf

DESCRIPTION="adds Subversion actions to the context menu of thunar"
HOMEPAGE="http://goodies.xfce.org/projects/thunar-plugins/thunar-svn-plugin"
SRC_URI="http://goodies.xfce.org/releases/${PN/vcs/svn}/${P/vcs/svn}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND=">=dev-util/subversion-1.5
	xfce-base/thunar"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P/vcs/svn}

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	PATCHES=( "${FILESDIR}/${P}-subversion-1.6.patch" )
	XFCONF="$(use_enable debug)"
}
