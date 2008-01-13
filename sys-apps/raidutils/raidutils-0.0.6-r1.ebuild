# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/raidutils/raidutils-0.0.6-r1.ebuild,v 1.2 2008/01/13 23:30:34 xmerlin Exp $

inherit eutils

DESCRIPTION="Utilities to manage i2o/dtp RAID controllers."
SRC_URI="http://i2o.shadowconnect.com/raidutils/${P}.tar.bz2"
HOMEPAGE="http://i2o.shadowconnect.com/"

KEYWORDS="x86"
IUSE=""

SLOT="0"
LICENSE="Adaptec"

DEPEND=">=sys-kernel/linux-headers-2.6"
RDEPEND=""

src_unpack () {
	unpack ${A}
	cd ${S}
	#epatch ${FILESDIR}/raidutils-0.0.5-i2octl-fixpath.patch || die
	#epatch ${FILESDIR}/raidutils-0.0.6-gcc41x-compilefix.patch || die
	epatch ${FILESDIR}/${P}-misc-fixes.patch || die
	rm -f include/linux/i2o-dev.h
}

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc NEWS INSTALL AUTHORS COPYING ChangeLog
}
