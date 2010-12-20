# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pe-format/pe-format-2.0.4.ebuild,v 1.2 2010/12/20 14:23:23 mgorny Exp $

inherit base

DESCRIPTION="Intelligent PE executable wrapper for binfmt_misc"
HOMEPAGE="https://github.com/mgorny/pe-format2/"
SRC_URI="http://cloud.github.com/downloads/mgorny/${PN}2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	base_src_install

	newinitd ${PN}.init ${PN} || die
	newconfd ${PN}.conf ${PN} || die
}
