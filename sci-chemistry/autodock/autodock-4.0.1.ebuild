# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/autodock/autodock-4.0.1.ebuild,v 1.1 2007/06/19 21:23:15 ribosome Exp $

MY_PN="autodocksuite"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A suite of automated docking tools"
HOMEPAGE="http://autodock.scripps.edu/"
SRC_URI="mirror://gentoo/${MY_PN}/${MY_P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}/src"

src_compile() {
	cd autodock/
	econf || die "econf failed"
	emake || die "build failed"
	cd ..

	cd autogrid/
	econf || die "econf failed"
	emake || die "build failed"
	cd ..
}

src_install() {
	dobin autodock/autodock4
	dobin autogrid/autogrid4
}
