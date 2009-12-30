# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-qtlibs/emul-linux-x86-qtlibs-20091226.ebuild,v 1.2 2009/12/30 19:50:50 pacho Exp $

inherit eutils emul-linux-x86

LICENSE="LGPL-2.1 GPL-3"
KEYWORDS="-* ~amd64"
IUSE=""

DEPEND=""
RDEPEND="=app-emulation/emul-linux-x86-baselibs-${PV}
	=app-emulation/emul-linux-x86-xlibs-${PV}"
