# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/blackbox/blackbox-0.65.0-r1.ebuild,v 1.1 2002/10/26 05:19:06 mkeadle Exp $

IUSE="nls"

inherit commonbox

S=${WORKDIR}/${P}
DESCRIPTION="A small, fast, full-featured window manager for X"
SRC_URI="mirror://sourceforge/blackboxwm/${P}.tar.gz"
HOMEPAGE="http://blackboxwm.sf.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

mydoc="AUTHORS LICENSE README ChangeLog* TODO*"

src_unpack() {
	unpack ${P}.tar.gz
	patch -p0 < ${FILESDIR}/blackbox-0.65.0-mousewheel_focus-workspace.patch
}
