# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdbg/kdbg-1.9.7.ebuild,v 1.1 2005/03/13 16:05:38 carlo Exp $

inherit kde

DESCRIPTION="A Graphical Debugger Interface to gdb"
SRC_URI="mirror://sourceforge/kdbg/${P}.tar.gz"
HOMEPAGE="http://members.nextra.at/johsixt/kdbg.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

RDEPEND=">=sys-devel/gdb-5.0"
need-kde 3