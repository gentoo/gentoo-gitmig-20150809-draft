# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xosview/xosview-1.8.2.ebuild,v 1.6 2004/10/19 09:06:55 absinthe Exp $

DESCRIPTION="X11 operating system viewer"
SRC_URI="mirror://sourceforge/xosview/${P}.tar.gz"
HOMEPAGE="http://xosview.sourceforge.net"

SLOT="0"
LICENSE="GPL-2 BSD"
KEYWORDS="x86 alpha ppc amd64 sparc"

DEPEND="virtual/x11"
IUSE=""

src_compile() {
	# 2.6 kernel compatibility has been fixed upstream...
	#if [ `uname -r | cut -d. -f1` -eq 2 -a `uname -r | cut -d. -f2` -ge 5 -a `uname -r | cut -d. -f2` -le 6 ] ; then
	#	einfo "You are running `uname -r`"
	#	einfo "Using 2.5/2.6 kernel compatibility patch"
	#	epatch ${FILESDIR}/xosview-1.8.1-kernel-2.5+.diff || die "patch failed"
	#fi

	econf || die "configuration failed"
	emake || die "compilation failed"
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
