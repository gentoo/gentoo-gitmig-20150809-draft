# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gnucap/gnucap-20050220.ebuild,v 1.4 2006/04/07 20:22:38 plasmaroo Exp $

inherit eutils

MY_PV="${PV:0:4}-${PV:4:2}-${PV:6}"

DESCRIPTION="GNUCap is the GNU Circuit Analysis Package"
SRC_URI="http://geda.seul.org/dist/gnucap-${MY_PV}.tar.gz"
HOMEPAGE="http://www.geda.seul.org/tools/gnucap"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND=""
S="${WORKDIR}/${PN}-${MY_PV}"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	insinto /usr/bin
	doins src/O/gnucap
	doins ibis/O/gnucap-ibis

	fperms 755 /usr/bin/gnucap
	fperms 755 /usr/bin/gnucap-ibis

	cd doc
	doman gnucap.1 gnucap-ibis.1
}
