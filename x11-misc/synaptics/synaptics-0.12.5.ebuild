# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/synaptics/synaptics-0.12.5.ebuild,v 1.1 2004/04/01 05:02:27 battousai Exp $

# This ebuild overwrites synaptics files installed by <= xfree-4.3.0-r3
# and xfree-4.3.99.14 >= X >= xfree-4.3.99.8.

DESCRIPTION="Driver for Synaptics touchpads"
HOMEPAGE="http://w1.894.telia.com/~u89404340/touchpad/"
SRC_URI="http://w1.894.telia.com/~u89404340/touchpad/files/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND=">=x11-base/xfree-4.3.0-r4"

src_unpack() {
	unpack ${A}

	# Put stuff into /usr/X11R6, also switch up the CC and CFLAGS stuff.
	sed -i -e "s:BINDIR = \\\$(DESTDIR)/usr/local/bin:BINDIR = ${D}/usr/X11R6/bin:g" ${S}/Makefile
	sed -i -e "s:CC = gcc:CC = ${CC}:g" ${S}/Makefile
	sed -i -e "s:CDEBUGFLAGS = -O2:CDEBUGFLAGS = ${CFLAGS}:g" ${S}/Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/X11R6/{bin,lib/modules/input}

	# Yes, they got the DESTDIR stuff going. And there was much rejoicing.
	make DESTDIR=${D} install || die
	dodoc {script/usbmouse,alps.patch,COMPATIBILITY,FILES,INSTALL{,.DE},LICENSE,NEWS,TODO,README{,.alps}}
	# Stupid new daemon, didn't work for me because of shm issues
	exeinto /etc/init.d && newexe ${FILESDIR}/rc.init syndaemon
	insinto /etc/conf.d && newins ${FILESDIR}/rc.conf syndaemon
}
