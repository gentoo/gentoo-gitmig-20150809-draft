# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/genext2fs/genext2fs-1.3-r1.ebuild,v 1.2 2004/08/03 11:36:19 dholm Exp $

inherit eutils

DESCRIPTION="generate ext2 file systems"
HOMEPAGE="http://packages.debian.org/unstable/admin/genext2fs"
SRC_URI="mirror://debian/pool/main/g/genext2fs/${PN}_${PV}.orig.tar.gz
	mirror://gentoo/${P}-uclibc-updates.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 arm mips ~ppc"
IUSE=""

DEPEND=""

S=${WORKDIR}/${P}.orig

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-uclibc-updates.patch
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	make install DESTDIR=${D} || die
}
