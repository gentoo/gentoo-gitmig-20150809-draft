# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/systrace/systrace-1.0-r4.ebuild,v 1.5 2004/01/26 01:08:55 vapier Exp $

DESCRIPTION="Systrace userland binary"
HOMEPAGE="http://www.systrace.org/"
SRC_URI="http://www.citi.umich.edu/u/provos/systrace/usr-systrace-2003-06-23.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gtk"

DEPEND="dev-libs/libevent
	gtk? ( =x11-libs/gtk+-1.2* =dev-libs/glib-1.2* )"

pkg_setup() {
	if ! [ -f ${ROOT}/usr/include/linux/systrace.h ] ;
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
		#die "need systrace in the kernel"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	[ `use gtk` ] || epatch ${FILESDIR}/${PV}-no-gtk.patch
	export WANT_AUTOCONF=2.5
}

src_install() {
	dobin systrace || die
	doman systrace.1
}
