# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-baselibs/emul-linux-x86-baselibs-1.2.2.ebuild,v 1.2 2004/08/29 03:45:50 lv Exp $

DESCRIPTION="Base libraries for emulation of 32bit x86 on amd64"
SRC_URI="http://dev.gentoo.org/~lv/emul-linux-x86-baselibs-${PV}.tar.bz2"
HOMEPAGE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* amd64"
IUSE=""

# stop confusing portage 0.o
S=${WORKDIR}

DEPEND="virtual/libc
	>=sys-apps/sed-4
	app-emulation/emul-linux-x86-glibc
	app-emulation/emul-linux-x86-compat"

src_install() {
	cd ${WORKDIR}
	cp -RPvf ${WORKDIR}/* ${D}/
}
