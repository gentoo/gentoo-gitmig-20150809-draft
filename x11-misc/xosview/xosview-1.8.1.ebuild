# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xosview/xosview-1.8.1.ebuild,v 1.2 2004/01/02 10:01:55 aliz Exp $

DESCRIPTION="X11 operating system viewer"
SRC_URI="mirror://sourceforge/xosview/${P}.tar.gz"
HOMEPAGE="http://xosview.sourceforge.net"

SLOT="0"
LICENSE="GPL-2 BSD"
KEYWORDS="x86 ~alpha ppc ~amd64"

DEPEND="virtual/x11"

src_compile() {

	if [ `uname -r | cut -d. -f1` -eq 2 -a `uname -r | cut -d. -f2` -ge 5 -a `uname -r | cut -d. -f2` -le 6 ] ; then
		einfo "You are running `uname -r`"
		einfo "Using 2.5/2.6 kernel compatibility patch"
		epatch ${FILESDIR}/xosview-1.8.1-kernel-2.5+.diff || die "patch failed"
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
	dodoc CHANGES COPYING README README.linux TODO
}
