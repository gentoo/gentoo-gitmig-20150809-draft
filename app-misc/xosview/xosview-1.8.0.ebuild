# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/xosview/xosview-1.8.0.ebuild,v 1.6 2003/02/13 09:13:46 vapier Exp $

DESCRIPTION="X11 operating system viewer"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/status/xstatus/${P}.tar.gz"
HOMEPAGE="http://xosview.sourceforge.net"

SLOT="0"
LICENSE="GPL-2 BSD"
KEYWORDS="x86 ppc"

DEPEND="virtual/x11"

src_compile() {
	if [ ${ARCH} = "ppc" ] ; then
		patch -p0 < ${FILESDIR}/xosview-1.8.0-ppc.diff || die "patch failed"
	fi
	econf
	emake || die

}

src_install() {
	exeinto /usr/bin
	doexe xosview
	insinto /usr/lib/X11
	cp Xdefaults XOsview
	doins XOsview
	into /usr
	doman *.1
}
