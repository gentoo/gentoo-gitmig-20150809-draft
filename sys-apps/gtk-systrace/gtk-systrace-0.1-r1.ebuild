# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gtk-systrace/gtk-systrace-0.1-r1.ebuild,v 1.3 2003/06/21 21:19:39 drobbins Exp $

DESCRIPTION="Systrace gtk notification gui"
HOMEPAGE="http://www.citi.umich.edu/u/provos/systrace/index.html"
SRC_URI="http://www.citi.umich.edu/u/provos/systrace/gtk-systrace-2002-12-01.tar.gz"
SLOT="0"
LICENSE="GPL-2"
S="${WORKDIR}/${P}"
FILESDIR="${WORKDIR}/notification-0.1"

KEYWORDS="x86 amd64"
IUSE="gtk"
DEPEND="sys-apps/systrace
	gtk? ( =x11-libs/gtk+-1.2* =dev-libs/glib-1.2* )"

src_compile() {
	cd ${FILESDIR}
	./autogen.sh || die
	emake || die
}

src_install() {
	cp ${FILESDIR}/src/notification xsystrace
	exeinto /usr/X11R6/bin
	doexe xsystrace
	
	dodir /usr/local/share/notification/pixmaps
	insinto /usr/local/share/notification/pixmaps
	doins ${FILESDIR}/pixmaps/*.xpm 
}
