# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdbg/kdbg-1.2.5.3.ebuild,v 1.3 2002/04/27 11:15:39 seemant Exp $

# 1.2.5 version links agaisnt KDE3
MY_PV=1.2.5
MY_P=${PN}-${MY_PV}

 . /usr/portage/eclass/inherit.eclass || die
inherit kde-base

need-kde 3

DESCRIPTION="A Graphical Debugger Interface to gdb"
SRC_URI="http://prdownloads.sourceforge.net/kdbg/${MY_P}.tar.gz"
HOMEPAGE="http://members.nextra.at/johsixt/kdbg.html"

myconf="$myconf --with-kde-version=3"

export LIBQTMT="-lqt-mt"

RDEPEND=">=sys-devel/gdb-5.0"
