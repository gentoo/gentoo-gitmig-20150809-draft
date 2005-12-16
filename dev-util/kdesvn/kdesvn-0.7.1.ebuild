# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdesvn/kdesvn-0.7.1.ebuild,v 1.1 2005/12/16 01:34:31 ka0ttic Exp $

inherit kde

DESCRIPTION="KDESvn is a frontend to the subversion vcs."
HOMEPAGE="http://www.alwins-world.de/programs/kdesvn/"
SRC_URI="http://www.alwins-world.de/programs/download/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-util/subversion-1.2
		net-misc/neon"

need-kde 3.3

pkg_postinst() {
	echo
	einfo "For nice graphical diffs, install kde-base/kompare."
	echo
}
