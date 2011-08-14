# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libbluedevil/libbluedevil-1.9.ebuild,v 1.4 2011/08/14 17:06:40 maekke Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="Qt wrapper for bluez used in the KDE bluetooth stack"
HOMEPAGE="http://projects.kde.org/projects/playground/libs/libbluedevil"
# upstream does not release tarballs
# always pack from git tag :/
SRC_URI="http://dev.gentoo.org/~scarabeus/${P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="amd64 ~arm x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	net-wireless/bluez
"
