# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-gtklibs/emul-linux-x86-gtklibs-1.2.ebuild,v 1.2 2004/08/29 03:45:50 lv Exp $

DESCRIPTION="Gtk+ 1/2 for emulation of 32bit x86 on amd64"
SRC_URI="http://dev.gentoo.org/~lv/emul-linux-x86-gtklibs-${PV}.tar.bz2"
HOMEPAGE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* amd64"
IUSE=""

S="${WORKDIR}"

DEPEND=">=app-emulation/emul-linux-x86-xlibs-1.2
	>=app-emulation/emul-linux-x86-baselibs-1.2.2"

src_install() {
	mkdir -p ${D}/etc/env.d
	echo "GDK_USE_XFT=1" > ${D}/etc/env.d/50emul-linux-x86-gtklibs
	cp -RPvf ${WORKDIR}/* ${D}/
}
