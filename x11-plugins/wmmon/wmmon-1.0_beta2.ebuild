# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmon/wmmon-1.0_beta2.ebuild,v 1.2 2002/10/04 06:45:55 vapier Exp $

S=${WORKDIR}/wmmon.app
DESCRIPTION="Dockable system resources monitor applette for WindowMaker"
WMMON_VERSION=1_0b2
SRC_URI="http://rpig.dyndns.org/~anstinus/Linux/wmmon-${WMMON_VERSION}.tar.gz"
HOMEPAGE="http://www.bensinclair.com/dockapp/"

DEPEND="x11-wm/WindowMaker"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	emake -C wmmon || die
}

src_install () {
	dobin wmmon/wmmon
	dodoc BUGS CHANGES COPYING HINTS INSTALL README TODO
}
