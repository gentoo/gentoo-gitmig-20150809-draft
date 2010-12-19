# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pe-format/pe-format-2.0.5.ebuild,v 1.1 2010/12/19 16:21:40 mgorny Exp $

EAPI=2
inherit autotools-utils

DESCRIPTION="Intelligent PE executable wrapper for binfmt_misc"
HOMEPAGE="https://github.com/mgorny/pe-format2/"
SRC_URI="https://github.com/downloads/mgorny/${PN}2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	autotools-utils_src_install

	cd "${AUTOTOOLS_BUILD_DIR}" || die
	newinitd ${PN}.init ${PN} || die
	newconfd ${PN}.conf ${PN} || die
}
