# Copyright 1999-2004 Gentoo Technologies, Inc., 2002-2003 Mike Frysinger
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdemu/cdemu-0.5.3.ebuild,v 1.2 2004/01/24 22:39:01 liquidx Exp $

inherit gcc python

MY_P=${PN}_${PV}
DESCRIPTION="mount bin/cue cd images"
HOMEPAGE="http://robert.private.outertech.com/virtualcd/"
SRC_URI="http://robert.private.outertech.com/virtualcd/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/kernel"
RDEPEND="dev-lang/python"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if [ "${KV:0:3}" != "2.4" ] ; then
		die "This package only works with 2.4.x kernels"
	else
		true
	fi
}

src_compile() {
	$(gcc-getCC) -c cdemu.c -o cdemu.o \
		${CFLAGS} -D__KERNEL__ -DMODULE -Wall \
		-I/usr/src/linux/include \
		|| die "could not make kernel module"
}

src_install() {
	dobin cdemu
	python_version
	insinto /usr/lib/python${PYVER}/site-packages
	doins libcdemu.py

	insinto /lib/modules/${KV}/kernel/fs/cdemu
	doins cdemu.o

	dodoc AUTHORS ChangeLog README TODO
}
