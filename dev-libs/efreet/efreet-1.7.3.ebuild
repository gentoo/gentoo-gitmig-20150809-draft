# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/efreet/efreet-1.7.3.ebuild,v 1.1 2012/12/08 14:32:10 tommy Exp $

EAPI=2

inherit enlightenment

DESCRIPTION="library for handling of freedesktop.org specs (desktop/icon/theme/etc...)"
SRC_URI="http://download.enlightenment.org/releases/${P}.tar.bz2"

KEYWORDS="~amd64 ~arm ~x86"
IUSE="static-libs"

RDEPEND=">=dev-libs/ecore-1.7.0
	>=dev-libs/eet-1.7.0
	>=dev-libs/eina-1.7.0
	x11-misc/xdg-utils"
DEPEND="${RDEPEND}"

src_configure() {
	MY_ECONF="
		$(use_enable doc)
	"

	enlightenment_src_configure
}
