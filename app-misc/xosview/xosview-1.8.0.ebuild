# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/xosview/xosview-1.8.0.ebuild,v 1.7 2003/08/28 09:15:43 plasmaroo Exp $

DESCRIPTION="X11 operating system viewer"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/status/xstatus/${P}.tar.gz"
HOMEPAGE="http://xosview.sourceforge.net"

SLOT="0"
LICENSE="GPL-2 BSD"
KEYWORDS="x86 ppc"

DEPEND="virtual/x11"

src_compile() {

	if [ `uname -r | cut -d. -f1` -eq 2 -a `uname -r | cut -d. -f2` -ge 5 -a `uname -r | cut -d. -f2` -le 6 ] ; then
		einfo "You are running `uname -r`"
		einfo "Using 2.5/2.6 kernel compatibility patch"
		epatch ${FILESDIR}/xosview-kernel-2.5+.diff || die "patch failed"
	fi

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
