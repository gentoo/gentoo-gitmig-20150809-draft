# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdbg/kdbg-1.2.5.3.ebuild,v 1.14 2003/03/13 10:12:37 doctomoe Exp $

IUSE=""
# 1.2.5 version links against KDE3
MY_PV=1.2.5
MY_P=${PN}-${MY_PV}

inherit kde-base

need-kde 3

S=${WORKDIR}/${MY_P}
DESCRIPTION="A Graphical Debugger Interface to gdb"
SRC_URI="mirror://sourceforge/kdbg/${MY_P}.tar.gz"
HOMEPAGE="http://members.nextra.at/johsixt/kdbg.html"

myconf="${myconf} --with-kde-version=3"

export LIBQTMT="-lqt-mt"


LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

RDEPEND=">=sys-devel/gdb-5.0"
