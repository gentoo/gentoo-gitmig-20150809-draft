# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rsbac-admin/rsbac-admin-1.2.1.ebuild,v 1.9 2004/07/15 02:30:02 agriffis Exp $

IUSE=""

# RSBAC Adming packet name
ADMIN=rsbac-admin-v${PV}

DESCRIPTION="Rule Set Based Access Control Admin Tools"
HOMEPAGE="http://www.rsbac.org"
SRC_URI="http://www.rsbac.org/code/rsbac-admin-v${PV}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"

DEPEND="
	dev-util/dialog"

RDEPEND=">=sys-libs/ncurses-5.2"

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
