# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pedro/pedro-1.5.ebuild,v 1.7 2010/10/29 20:06:51 keri Exp $

EAPI=1

inherit eutils

DESCRIPTION="Pedro is a subscription/notification communications system"
HOMEPAGE="http://www.itee.uq.edu.au/~pjr/HomePages/PedroHome.html"
SRC_URI="http://www.itee.uq.edu.au/~pjr/HomePages/PedroFiles/${P}.tgz
	doc? ( mirror://gentoo/${PN}-manual-${PV}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="doc examples"

DEPEND="dev-libs/glib:2"

S="${WORKDIR}"/${P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-portage.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS README || die

	if use doc ; then
		dodoc "${WORKDIR}"/${PN}.pdf || die
	fi

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins src/examples/*.{c,tcl} || die
		insinto /usr/share/doc/${PF}/examples/java_api
		doins src/java_api/*.java || die
		insinto /usr/share/doc/${PF}/examples/python_api
		doins src/python_api/*.py || die
	fi
}
