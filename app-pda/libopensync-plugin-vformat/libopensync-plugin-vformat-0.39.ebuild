# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-vformat/libopensync-plugin-vformat-0.39.ebuild,v 1.2 2009/11/16 01:45:09 mr_bones_ Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="OpenSync VFormat Plugin"
HOMEPAGE="http://www.opensync.org"
SRC_URI="http://www.opensync.org/download/releases/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

RDEPEND="=app-pda/libopensync-${PV}*
	dev-libs/glib:2"
DEPEND="${RDEPEND}
	test? ( dev-libs/check )"

# 0% tests passed, 4 tests failed out of 4
RESTRICT="test"
