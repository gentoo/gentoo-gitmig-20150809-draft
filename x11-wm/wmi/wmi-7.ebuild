# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/wmi/wmi-7.ebuild,v 1.2 2004/06/08 12:41:54 dholm Exp $

DESCRIPTION="WMI is a new window manager for X11, which combines the best features of larswm, ion, evilwm and ratpoison into one window manager."
SRC_URI="http://download.berlios.de/wmi/${P}.tar.gz"
HOMEPAGE="http://wmi.berlios.de/"
LICENSE="as-is"
DEPEND="virtual/x11
	dev-libs/STLport"
KEYWORDS="~x86 ~ppc"
SLOT="0"

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
	docinto examples
	dodoc examples/*
	docinto themes
	dodoc examples/themes/*

	echo -e "#!/bin/sh\n/usr/bin/wmi" > ${T}/wmi
	exeinto /etc/X11/Sessions
	doexe ${T}/wmi
}
