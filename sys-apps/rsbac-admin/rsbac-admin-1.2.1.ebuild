# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rsbac-admin/rsbac-admin-1.2.1.ebuild,v 1.1 2003/02/07 19:38:20 rphillips Exp $

# RSBAC Adming packet name
ADMIN=rsbac-admin-v1.2.1

DESCRIPTION="Rule Set Based Access Control Admin Tools"
HOMEPAGE="http://www.rsbac.org"
SRC_URI="http://www.rsbac.org/code/rsbac-admin-v1.2.1.tar.bz2" 
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="ncurses"
DEPEND="sys-kernel/rsbac-sources app-misc/dialog"
RDEPEND=">=sys-libs/ncurses-5.2"

S=${WORKDIR}/${P}

src_unpack() {
        cd ${WORKDIR}
        unpack ${ADMIN}.tar.bz2 || die "cannot unpack rsbac-admin tool"

}

src_compile() {

		cd ${WORKDIR}/${ADMIN}
		echo "-> Configuring and compiling RSBAC Admin Tools"
		econf || die "cannot ./configure RSBAC Admin Tools"
		emake || die "cannot make RSBAC Admin Tools"
}

src_install() {
		cd ${WORKDIR}/${ADMIN}
		einstall || die "cannot make install"
		einfo "-> RSBAC admin tools installed"
		einfo ">>> *** IMPORTANT *** <<<"
		einfo "Take a look at http://www.rsbac.org if you are not an expert of RSBAC managing"
}
