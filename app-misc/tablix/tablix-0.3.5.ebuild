# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tablix/tablix-0.3.5.ebuild,v 1.1 2008/01/08 23:35:00 carlo Exp $

inherit eutils

MY_PV="${PN}2-${PV}"

DESCRIPTION="Tablix is a powerful free software kernel for solving general timetabling problems."
HOMEPAGE="http://www.tablix.org/"
SRC_URI="http://www.tablix.org/releases/stable/${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="pvm"

DEPEND=">=dev-libs/libxml2-2.4.3
	pvm?	( sys-cluster/pvm )"

S="${WORKDIR}/${MY_PV}"

pkg_setup() {
	if ! use pvm; then
		ewarn
		ewarn "Without parallel virtual machine support, tablix will not be able"
		ewarn "to solve even moderately complex problems.  Even if you are using"
		ewarn "a single machine, USE=pvm is highly recommended."
		ewarn
		epause 5
	fi
}

src_compile() {
	econf \
		$(use_with pvm pvm3) \
		|| die

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS ChangeLog NEWS README
	cd doc
	dodoc manual.pdf modules.pdf modules2.pdf morphix.pdf
}
