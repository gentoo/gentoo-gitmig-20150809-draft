# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ktail/ktail-0.6.1.ebuild,v 1.16 2003/07/16 14:43:49 pvdabeel Exp $

inherit kde-base

need-kde 3

DESCRIPTION="monitor multiple files and/or command output in one window"
SRC_URI="http://www.franken.de/users/duffy1/rjakob/${P}.tar.bz2"
HOMEPAGE="http://www.franken.de/users/duffy1/rjakob/"

LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

src_unpack() {
	unpack ${A}
	cd ${S}/${PN}
	rm removedlg.h removedlg.cpp logoptdlg.h logoptdlg.cpp cmdlinedlg.h \
	   cmdlinedlg.cpp filterdlg.h filterdlg.cpp
}
