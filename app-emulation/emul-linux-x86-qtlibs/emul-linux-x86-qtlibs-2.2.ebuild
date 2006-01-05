# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-qtlibs/emul-linux-x86-qtlibs-2.2.ebuild,v 1.2 2006/01/05 21:55:49 herbs Exp $

DESCRIPTION="QT 2/3 libraries for emulation of 32bit x86 on amd64"
SRC_URI="mirror://gentoo/emul-linux-x86-qtlibs-${PV}.tar.bz2"
HOMEPAGE="http://www.gentoo.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* amd64"
IUSE=""

RDEPEND="virtual/libc
	>=app-emulation/emul-linux-x86-xlibs-2.0"

src_install() {
	cp -RPvf ${WORKDIR}/* ${D}/
	doenvd ${FILESDIR}/45emul-linux-x86-qtlibs
}
