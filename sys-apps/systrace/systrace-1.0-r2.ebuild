# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:


DESCRIPTION="Systrace userland binary"
HOMEPAGE="http://www.systrace.org"
SRC_URI="http://www.citi.umich.edu/u/provos/systrace/usr-systrace-2003-04-27.tar.gz
	http://natey.com/gentoo/systrace/patches/systrace.c-no_x11-1.0.patch.gz"
SLOT="0"
LICENSE="GPL-2"
PATCH1="systrace.c-no_x11-1.0.patch"
INCLUDE0="/usr/src/linux/include/linux/systrace.h"
INCLUDE1="/usr/include/linux/systrace.h"
S="${WORKDIR}/${P}"

KEYWORDS="~x86"
IUSE="gtk"
DEPEND="gtk? ( =x11-libs/gtk+-1.2* =dev-libs/glib-1.2* )"

pkg_setup() {
	if ! [ -f ${INCLUDE0} ] || ! [ -f ${INCLUDE1} ] ; 
	then
		einfo
		einfo "ERROR: It does not look like you have a systrace capable kernel. If"
		einfo "this is incorrect, please copy /usr/src/linux/include/linux/systrace.h"
		einfo "to /usr/include/linux/ and restart the build."
		einfo
		einfo "The latest systrace Linux kernel patches can be found at:"
		einfo
		einfo "http://www.citi.umich.edu/u/provos/systrace/linux.html"
		einfo
		exit 1
	fi
}

src_compile() {
	if [ "`use gtk`" ]
	then
		einfo
		einfo "You are building systrace with gtk support; this version will not" 
		einfo "function without the sys-apps/gtk-systrace package installed. Please" 
		einfo "set the USE=\"-gtk\" to build the non-gui capable version of systrace." 
		einfo
		sleep 7 
		./configure --host=${CHOST} || die
	elif [ -z "`use gtk`" ]
	then
		einfo
		einfo "You are building systrace without gtk support; please set USE=\"gtk\"" 
		einfo "to build the gui capable version of systrace."
		einfo
		sleep 7 
		cd ${S}
		epatch ../${PATCH1} || die
		./configure --host=${CHOST} || die
	fi 

	emake || die
}

src_install() {
	dobin systrace
	exeinto /usr/bin

	doman systrace.1
}
