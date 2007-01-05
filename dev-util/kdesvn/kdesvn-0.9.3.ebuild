# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdesvn/kdesvn-0.9.3.ebuild,v 1.4 2007/01/05 16:53:17 flameeyes Exp $

inherit eutils kde

DESCRIPTION="KDESvn is a frontend to the subversion vcs."
HOMEPAGE="http://www.alwins-world.de/programs/kdesvn/"
SRC_URI="http://www.alwins-world.de/programs/download/${PN}/old/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-util/subversion-1.3
		net-misc/neon"

need-kde 3.3

pkg_postinst() {
	if ! has_version 'kde-base/kompare'; then
		echo
		elog "For nice graphical diffs, install kde-base/kompare."
		echo
	fi
}
