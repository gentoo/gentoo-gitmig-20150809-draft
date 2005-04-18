# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-gtklibs/emul-linux-x86-gtklibs-2.1.ebuild,v 1.1 2005/04/18 10:10:11 herbs Exp $

DESCRIPTION="Gtk+ 1/2 for emulation of 32bit x86 on amd64"
SRC_URI="mirror://gentoo/emul-linux-x86-gtklibs-${PV}.tar.bz2"
HOMEPAGE="http://www.gentoo.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ~amd64"
IUSE=""

S="${WORKDIR}"

RDEPEND=">=app-emulation/emul-linux-x86-xlibs-2.0
	>=app-emulation/emul-linux-x86-baselibs-2.0"

src_install() {
	mkdir -p ${D}/etc/env.d
	echo "GDK_USE_XFT=1" > ${D}/etc/env.d/50emul-linux-x86-gtklibs
	chmod 644 ${D}/etc/env.d/50emul-linux-x86-gtklibs
	cp -RPvf ${WORKDIR}/* ${D}/
}
