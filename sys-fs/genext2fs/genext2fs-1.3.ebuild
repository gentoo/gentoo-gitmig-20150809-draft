# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/genext2fs/genext2fs-1.3.ebuild,v 1.1 2004/07/25 07:22:15 vapier Exp $

inherit eutils

DEB_V=6
DESCRIPTION="generate ext2 file systems"
HOMEPAGE="http://packages.debian.org/unstable/admin/genext2fs"
SRC_URI="mirror://debian/pool/main/g/genext2fs/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/g/genext2fs/${PN}_${PV}-${DEB_V}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${P}.orig

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${PN}_${PV}-${DEB_V}.diff
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc dev.txt
}
