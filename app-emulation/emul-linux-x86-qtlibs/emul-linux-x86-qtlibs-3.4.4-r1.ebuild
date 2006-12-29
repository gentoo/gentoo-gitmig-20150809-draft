# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-qtlibs/emul-linux-x86-qtlibs-3.4.4-r1.ebuild,v 1.1 2006/12/29 20:08:09 kugelfang Exp $

DESCRIPTION="QT 2/3 libraries for emulation of 32bit x86 on amd64"
SRC_URI="immqt-bc? ( mirror://gentoo/emul-linux-x86-qtlibs-immqt-${PV}.tar.bz2 )
	!immqt-bc? ( mirror://gentoo/emul-linux-x86-qtlibs-noime-${PV}.tar.bz2 )
	mirror://gentoo/emul-linux-x86-qtlibs-extras-${PV}.tar.bz2"
HOMEPAGE="http://www.gentoo.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* amd64"
IUSE="immqt-bc"

RDEPEND="virtual/libc
	>=app-emulation/emul-linux-x86-baselibs-2.5
	>=app-emulation/emul-linux-x86-xlibs-7.0"

RESTRICT="nostrip"

src_install() {
	cp -RPvf ${WORKDIR}/* ${D}/
	doenvd ${FILESDIR}/45emul-linux-x86-qtlibs
}
