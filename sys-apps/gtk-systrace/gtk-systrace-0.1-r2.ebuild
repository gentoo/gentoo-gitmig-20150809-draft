# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gtk-systrace/gtk-systrace-0.1-r2.ebuild,v 1.5 2004/03/15 02:00:43 seemant Exp $

IUSE="gtk"

DESCRIPTION="Systrace gtk notification gui"
HOMEPAGE="http://www.systrace.org"
SRC_URI="http://www.citi.umich.edu/u/provos/systrace/gtk-systrace-2003-06-23.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

FILES_DIR="${WORKDIR}/notification-0.1"

DEPEND="sys-apps/systrace
	gtk? ( =x11-libs/gtk+-1.2* =dev-libs/glib-1.2* )"

src_compile() {
	cd ${FILES_DIR}
	./autogen.sh || die
	emake || die
}

src_install() {
	cp ${FILES_DIR}/src/notification xsystrace
	exeinto /usr/X11R6/bin
	doexe xsystrace

	dodir /usr/local/share/notification/pixmaps
	insinto /usr/local/share/notification/pixmaps
	doins ${FILES_DIR}/pixmaps/*.xpm
}
