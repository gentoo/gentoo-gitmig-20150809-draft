# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/blackbox/blackbox-0.65.0-r2.ebuild,v 1.3 2003/11/11 23:47:27 tseng Exp $

IUSE="nls"

inherit commonbox

S=${WORKDIR}/${P}
DESCRIPTION="A small, fast, full-featured window manager for X - with mousewheel patch"
SRC_URI="mirror://sourceforge/blackboxwm/${P}.tar.gz"
HOMEPAGE="http://blackboxwm.sf.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
MYCONF="--disable-nls"

mydoc="AUTHORS LICENSE README ChangeLog* TODO* data/README*"

src_unpack() {
	unpack ${P}.tar.gz
	epatch ${FILESDIR}/blackbox-0.65.0-mousewheel_focus-workspace.patch
	epatch ${FILESDIR}/blackbox-gcc.patch
	cd ${S}/data
	mv README README.data
}

pkg_postinst() {
	ewarn
	ewarn "This build of Blackbox makes use of the mousewheel patch, allowing you"
	ewarn "to use the mousewheel change workspace or application focus."
	ewarn "Please note that NLS support is now *disabled*, as it is horribly broken."
	ewarn
}
