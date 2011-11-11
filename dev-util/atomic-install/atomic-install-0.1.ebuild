# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/atomic-install/atomic-install-0.1.ebuild,v 1.1 2011/11/11 16:29:42 mgorny Exp $

EAPI=4
inherit autotools-utils

DESCRIPTION="A library and tool to atomically install sets of files"
HOMEPAGE="https://github.com/mgorny/atomic-install/"
SRC_URI="mirror://github/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs xattr"

RDEPEND="xattr? ( sys-apps/attr )"
DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-1.18 )"

src_configure() {
	myeconfargs=(
		$(use_enable doc gtk-doc)
		$(use_enable xattr libattr)
	)

	autotools-utils_src_configure
}
