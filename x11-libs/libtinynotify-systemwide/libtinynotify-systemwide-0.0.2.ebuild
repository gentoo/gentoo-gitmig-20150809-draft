# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libtinynotify-systemwide/libtinynotify-systemwide-0.0.2.ebuild,v 1.1 2012/01/24 20:56:32 mgorny Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="A system-wide notifications module for libtinynotify"
HOMEPAGE="https://github.com/mgorny/libtinynotify-systemwide/"
SRC_URI="mirror://github/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

RDEPEND="sys-process/procps
	x11-libs/libtinynotify"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )"

DOCS=( README )

src_configure() {
	myeconfargs=(
		$(use_enable doc gtk-doc)
	)

	autotools-utils_src_configure
}
