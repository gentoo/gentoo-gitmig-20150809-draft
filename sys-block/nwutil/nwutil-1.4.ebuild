# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/nwutil/nwutil-1.4.ebuild,v 1.1 2005/03/06 00:50:07 ciaranm Exp $

inherit eutils

DEB_VER=3
DESCRIPTION="Netwinder hardware utilities"
HOMEPAGE="http://packages.debian.org/stable/base/nwutil"
SRC_URI="mirror://debian/pool/main/n/nwutil/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/n/nwutil/${PN}_${PV}-${DEB_VER}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* arm"
IUSE=""

DEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${PN}_${PV}-${DEB_VER}.diff
	epatch ${FILESDIR}/${PV}-errno.patch
	epatch ${FILESDIR}/${PV}-rename-debug.patch
	mv {,nw}debug.c; mv {,nw}debug.8
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake main failed"
	cd flashlogo
	emake || die "emake flashlogo failed"
}

src_install() {
	make DESTDIR=${D} install || die "install main failed"
	cd flashlogo
	make DESTDIR=${D} install || die "install flashlogo failed"
}
