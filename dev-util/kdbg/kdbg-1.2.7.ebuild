# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdbg/kdbg-1.2.7.ebuild,v 1.4 2003/04/05 22:05:07 danarmak Exp $

inherit kde-base

need-kde 3

IUSE=""
DESCRIPTION="A Graphical Debugger Interface to gdb"
SRC_URI="mirror://sourceforge/kdbg/${P}.tar.gz"
HOMEPAGE="http://members.nextra.at/johsixt/kdbg.html"

myconf="${myconf} --with-kde-version=3"

export LIBQTMT="-lqt-mt"

LICENSE="GPL-2"
KEYWORDS="x86 ~sparc  ~ppc"

RDEPEND=">=sys-devel/gdb-5.0"
