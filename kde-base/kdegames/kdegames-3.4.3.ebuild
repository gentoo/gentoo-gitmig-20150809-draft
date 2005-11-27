# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-3.4.3.ebuild,v 1.4 2005/11/27 17:45:24 gmsoft Exp $

inherit kde-dist

DESCRIPTION="KDE games (not just solitaire ;-)"

KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ~ppc sparc ~x86"
IUSE=""

# For backgrounds in kpat.
RDEPEND="~kde-base/kdebase-${PV}"

src_compile() {
	local myconf="--disable-setgid"

	kde_src_compile
}
