# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libtinynotify-cli/libtinynotify-cli-0.0.1.ebuild,v 1.1 2011/08/21 20:48:24 mgorny Exp $

EAPI=4
inherit autotools-utils

DESCRIPTION="A CLI module for libtinynotify"
HOMEPAGE="https://github.com/mgorny/libtinynotify-cli/"
SRC_URI="http://cloud.github.com/downloads/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

RDEPEND="x11-libs/libtinynotify"
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )"

DOCS=( README )

src_configure() {
	myeconfargs=(
		$(use_enable doc gtk-doc)
	)

	autotools-utils_src_configure
}
