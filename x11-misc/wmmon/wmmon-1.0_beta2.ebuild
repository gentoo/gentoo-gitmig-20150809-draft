# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmmon/wmmon-1.0_beta2.ebuild,v 1.6 2002/08/14 23:44:15 murphy Exp $
S=${WORKDIR}/wmmon.app

DESCRIPTION="Dockable system resources monitor applette for WindowMaker"

WMMON_VERSION=1_0b2
SRC_URI="http://rpig.dyndns.org/~anstinus/Linux/wmmon-${WMMON_VERSION}.tar.gz"
HOMEPAGE="http://www.bensinclair.com/dockapp/"
DEPEND="x11-base/xfree x11-wm/WindowMaker virtual/glibc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	emake -C wmmon || die
}

src_install () {
	dobin wmmon/wmmon
	dodoc BUGS CHANGES COPYING HINTS INSTALL README TODO
}
