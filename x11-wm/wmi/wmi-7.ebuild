# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/wmi/wmi-7.ebuild,v 1.6 2004/08/30 19:19:31 pvdabeel Exp $

DESCRIPTION="WMI is a new window manager for X11, which combines the best features of larswm, ion, evilwm and ratpoison into one window manager."
HOMEPAGE="http://wmi.berlios.de/"
SRC_URI="http://download.berlios.de/wmi/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/x11
	dev-libs/STLport"

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
