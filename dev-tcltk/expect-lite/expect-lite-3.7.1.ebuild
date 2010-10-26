# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/expect-lite/expect-lite-3.7.1.ebuild,v 1.2 2010/10/26 14:29:10 vapier Exp $

DESCRIPTION="quick and easy command line automation tool built on top of expect"
HOMEPAGE="http://expect-lite.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug examples"

RDEPEND="dev-tcltk/expect
	debug? ( dev-tcltk/tclx )"

S=${WORKDIR}/${PN}.proj

src_install() {
	dobin ${PN} || die
	dodoc README
	dohtml Docs/*

	if use examples ; then
		docinto examples
		dodoc Examples/* || die
	fi
}
