# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:


DESCRIPTION="Systrace userland binary"
HOMEPAGE="http://www.citi.umich.edu/u/provos/systrace/index.html"
SRC_URI="http://www.citi.umich.edu/u/provos/systrace/usr-systrace-2003-01-26.tar.gz
	http://natey.com/gentoo/systrace/patches/systrace.c-no_x11-1.0.patch.gz"
SLOT="0"
LICENSE="GPL-2"
KERNEL="linux-2.4.20-systrace-r2"
PATCH1="systrace.c-no_x11-1.0.patch"
S="${WORKDIR}/${P}"

KEYWORDS="~x86"
IUSE="gtk"
DEPEND="gtk? ( =x11-libs/gtk+-1.2* =dev-libs/glib-1.2* )"

src_compile() {
	cp /usr/src/${KERNEL}/include/linux/systrace.h /usr/include/linux/ || die
	if [ "`use gtk`" ]
	then
		einfo
		einfo "You are building systrace with gtk support; this version will not" 
		einfo "function without the sys-apps/gtk-systrace package installed. Please" 
		einfo "unset the gtk USE variable to build the non-gui capable version of" 
		einfo "systrace."
		einfo
		sleep 7 
		./configure --host=${CHOST} || die
	elif [ -z "`use gtk`" ]
	then
		einfo
		einfo "You are building systrace without gtk support; please set the gtk USE" 
		einfo "variable to build the gui capable version of systrace."
		einfo
		sleep 7 
		cd ${S}
		patch < ../${PATCH1} || die
		./configure --host=${CHOST} || die
	fi 

	emake || die
}

src_install() {
	dobin systrace
	exeinto /usr/bin

	doman systrace.1
}
