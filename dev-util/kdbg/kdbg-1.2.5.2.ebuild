# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdbg/kdbg-1.2.5.2.ebuild,v 1.1 2002/04/04 22:50:11 danarmak Exp $
# 1.2.5 version links against KDE2
PV=1.2.5
P=${PN}-${PV}

 . /usr/portage/eclass/inherit.eclass || die
inherit kde-base

need-kde 2

DESCRIPTION="A Graphical Debugger Interface to gdb"
SRC_URI="http://prdownloads.sourceforge.net/kdbg/kdbg-1.2.5.tar.gz"
HOMEPAGE="http://members.nextra.at/johsixt/kdbg.html"

myconf="$myconf --with-kde-version=2"
