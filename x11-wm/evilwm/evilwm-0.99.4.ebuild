# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/evilwm/evilwm-0.99.4.ebuild,v 1.11 2004/07/15 01:11:43 agriffis Exp $

DESCRIPTION="A minimalist, no frills window manager for X."
SRC_URI="http://download.sourceforge.net/evilwm/${PN}_${PV}-1.tar.gz"
HOMEPAGE="http://evilwm.sourceforge.net"

IUSE=""
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc ppc"

DEPEND="virtual/x11
	virtual/libc"

RDEPEND="$DEPEND"

src_compile() {
	emake allinone || die
}

src_install () {
	dodoc ChangeLog README*

	exeinto /usr/bin
	doexe evilwm

	doman evilwm.1
}
