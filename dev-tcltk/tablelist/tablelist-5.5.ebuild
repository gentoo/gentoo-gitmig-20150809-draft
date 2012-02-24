# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tablelist/tablelist-5.5.ebuild,v 1.3 2012/02/24 15:15:24 phajdan.jr Exp $

EAPI=4

inherit multilib

MY_P="${PN}${PV}"

DESCRIPTION="Multi-Column Listbox Package"
HOMEPAGE="http://www.nemethi.de/tablelist/index.html"
SRC_URI="http://www.nemethi.de/tablelist/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-lang/tcl"
DEPEND=""

S="${WORKDIR}/${MY_P}"

src_install() {
	insinto /usr/$(get_libdir)/${MY_P}
	doins -r ${PN}* pkgIndex.tcl scripts
	dohtml doc/*
	dodoc README.txt
}
