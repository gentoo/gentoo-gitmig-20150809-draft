# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-taskmanager/xfce4-taskmanager-0.5.92.ebuild,v 1.1 2010/05/28 14:36:58 angelos Exp $

EAPI=2
inherit xfconf

DESCRIPTION="Task Manager"
HOMEPAGE="http://goodies.xfce.org/projects/applications/xfce4-taskmanager"
SRC_URI="http://dl.dropbox.com/u/2670286/taskmgr/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.12:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README THANKS"
	XFCONF="--disable-dependency-tracking
		$(use_enable debug)"
}
