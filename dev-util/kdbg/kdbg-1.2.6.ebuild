# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdbg/kdbg-1.2.6.ebuild,v 1.2 2002/12/01 16:38:02 hannes Exp $

inherit kde-base

need-kde 3

IUSE=""
DESCRIPTION="A Graphical Debugger Interface to gdb"
SRC_URI="mirror://sourceforge/kdbg/${P}.tar.gz"
HOMEPAGE="http://members.nextra.at/johsixt/kdbg.html"

myconf="${myconf} --with-kde-version=3"

export LIBQTMT="-lqt-mt"

LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~sparc64"

RDEPEND=">=sys-devel/gdb-5.0"
