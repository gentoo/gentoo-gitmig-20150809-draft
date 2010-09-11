# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/talika/talika-0.50.ebuild,v 1.1 2010/09/11 14:11:43 hwoarang Exp $

EAPI=3

inherit autotools base

MY_PV="${PV}-1"
MY_P="${PN}_${MY_PV}"

DESCRIPTION="Gnome panel applet that lets you switch between open windows using
icons"
HOMEPAGE="http://talika.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/libwnck
	dev-cpp/libpanelappletmm"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-docs.patch
	)

DOCS=( NEWS ChangeLog TODO README AUTHORS )

src_prepare() {
	base_src_prepare
	# need to add missing files to po/POTFILES.in because testsuite fails
	# bug 322163
	echo -e "src/talika.schemas.in\nsrc/talika.server.in" >> po/POTFILES.in
	eautoreconf
}
