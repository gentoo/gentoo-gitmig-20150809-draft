# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/blackbox/blackbox-0.65.0-r1.ebuild,v 1.3 2003/02/13 17:46:39 vapier Exp $

IUSE="nls"

inherit commonbox

S=${WORKDIR}/${P}
DESCRIPTION="A small, fast, full-featured window manager for X - with mousewheel patch"
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

pkg_postinst() {
	ewarn
	ewarn "This build of Blackbox makes use of the mousewheel patch, allowing you"
	ewarn "to use the mousewheel chage workspace or application focus."
	ewarn "It is known to have a few issues. For a default install of Blackbox"
	ewarn "you may emerge ${PN}-${PV}."
	ewarn
}
