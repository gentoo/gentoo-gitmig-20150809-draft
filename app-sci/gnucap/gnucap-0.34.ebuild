# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gnucap/gnucap-0.34.ebuild,v 1.4 2004/10/07 19:02:07 hansmi Exp $

inherit eutils

DESCRIPTION="GNUCap is the GNU Circuit Analysis Package"
SRC_URI="http://geda.seul.org/dist/gnucap-${PV}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gnucap"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND=">=sys-libs/glibc-2.1.3"

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
	dodoc COPYING acs-tutorial whatisit history
	doman gnucap.1 gnucap-ibis.1
}
