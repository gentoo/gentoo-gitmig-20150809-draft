# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/xpde/xpde-0.1.1.ebuild,v 1.2 2003/02/13 17:56:11 vapier Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A Desktop Environment modelled after the O/S from Redmond, WA"
HOMEPAGE="http://www.xpde.com/"
SRC_URI="http://www.xpde.com/e/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc -sparc -alpha"

DEPEND="virtual/x11"

src_install() {

	echo "/opt/xpde/XPde full \$*" > startXPDE
	echo "/opt/xpde/XPwm \$*" > startXPWM

	exeinto /usr/bin
	doexe ${FILESDIR}/xpde

	exeinto /opt/xpde
	doexe XP* start* appexec taskmanager networkstatus

	dolib *.so*
	
	into /opt/xpde
	dolib bpldesk.so
	
	insinto /opt/xpde/themes/default/32x32/filetypes
	doins themes/default/32x32/filetypes/*

	insinto /opt/xpde/themes/default/32x32/system
	doins themes/default/32x32/system/*

	dodoc INSTALL gpl.txt

	insinto /usr/share/pixmaps
	newins ${WORKDIR}/.${PN}/Wallpapers/default.jpg default-xpde.jpg

	cd ${WORKDIR}
	tar jcf homedirsettings.tar.bz2 .xpde

	insinto /usr/share/xpde
	doins homedirsettings.tar.bz2
}
