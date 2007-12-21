# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-kdepim/libopensync-plugin-kdepim-0.35.ebuild,v 1.1 2007/12/21 23:15:45 peper Exp $

inherit cmake-utils kde-functions

DESCRIPTION="OpenSync Kdepim Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://www.opensync.org/download/releases/${PV}/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="=app-pda/libopensync-${PV}*
	|| ( kde-base/libkcal kde-base/kdepim )"
RDEPEND="${DEPEND}"

pkg_setup() {
	set-kdedir "3.5"
}
