# Copyright 1999-2003 Gentoo Technologies, Inc. and Tim Yamin <plasmaroo@gentoo.org> <plasmaroo@squirrelserver.org.uk>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gnucap/gnucap-0.33.ebuild,v 1.1 2003/11/28 22:07:24 plasmaroo Exp $

S=${WORKDIR}/${P}

DESCRIPTION="GNUCap is the GNU Circuit Analysis Package"
SRC_URI="http://geda.seul.org/dist/gnucap-${PV}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gnucap"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {

	econf || die
	emake || die

}

src_install () {

	insinto /usr/bin
	doins src/O/gnucap
	dodoc doc/COPYING doc/acs-tutorial doc/whatisit

}
