# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gnucap/gnucap-0.34.ebuild,v 1.6 2005/11/04 21:37:10 plasmaroo Exp $

inherit eutils

DESCRIPTION="GNUCap is the GNU Circuit Analysis Package"
SRC_URI="http://geda.seul.org/dist/gnucap-${PV}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gnucap"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"

DEPEND=""

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gcc-3.4.patch
}

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
