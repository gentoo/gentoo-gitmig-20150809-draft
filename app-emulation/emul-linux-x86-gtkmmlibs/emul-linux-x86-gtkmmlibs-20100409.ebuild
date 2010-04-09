# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-gtkmmlibs/emul-linux-x86-gtkmmlibs-20100409.ebuild,v 1.1 2010/04/09 17:33:49 pacho Exp $

inherit emul-linux-x86

LICENSE="LGPL-2 LGPL-2.1 GPL-2"
KEYWORDS="-* ~amd64"
IUSE=""

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-baselibs-${PV}
	~app-emulation/emul-linux-x86-cpplibs-${PV}
	~app-emulation/emul-linux-x86-gtklibs-${PV}
	~app-emulation/emul-linux-x86-xlibs-${PV}"
