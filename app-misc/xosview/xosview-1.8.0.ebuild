# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/xosview/xosview-1.8.0.ebuild,v 1.2 2002/07/24 22:42:37 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="X11 operating system viewer"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/status/xstatus/${P}.tar.gz"
HOMEPAGE="http://xosview.sourceforge.net"
LICENSE="GPL-2 BSD"
KEYWORDS="x86 ppc"
SLOT="0"

DEPEND="virtual/x11"

src_compile() {
	cd ${S}
	if [ ${ARCH} = "ppc" ] ; then
		patch -p0 < ${FILESDIR}/xosview-1.8.0-ppc.diff || die "patch failed"
	fi
	econf || die
	emake || die

}

src_install () {

	exeinto /usr/bin
	doexe xosview
	insinto /usr/lib/X11
	cp Xdefaults XOsview
	doins XOsview
	into /usr
	doman *.1

}
