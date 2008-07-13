# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-kdepim/libopensync-plugin-kdepim-0.36.ebuild,v 1.2 2008/07/13 07:07:12 josejx Exp $

inherit cmake-utils kde-functions

DESCRIPTION="OpenSync Kdepim Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://www.opensync.org/download/releases/${PV}/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="=app-pda/libopensync-${PV}*
	|| ( kde-base/libkcal kde-base/kdepim )"
RDEPEND="${DEPEND}"

pkg_setup() {
	set-kdedir "3.5"
}
