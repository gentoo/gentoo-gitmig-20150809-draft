# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/synaptics/synaptics-0.12.1.ebuild,v 1.2 2004/02/29 15:14:25 aliz Exp $

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
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	# This Makefile sucks. no prefix, no DESTDIR, nothing useful.
	# At some point I'd like to fix that and submit upstream.
	sed -i -e "s:BINDIR = /usr/local/bin:BINDIR = ${D}/usr/X11R6/bin:g" ${S}/Makefile
	sed -i -e "s:CC = gcc:CC = ${CC}:g" ${S}/Makefile
	sed -i -e "s:CDEBUGFLAGS = -O2:CDEBUGFLAGS = ${CFLAGS}:g" ${S}/Makefile
}

src_compile() {
	emake || die
}

src_install() {
	# Dies with sandbox violation if we don't change this
	sed -i -e "s:INSTALLED_X = /usr/X11R6:INSTALLED_X = ${D}/usr/X11R6:g" ${S}/Makefile

	dodir /usr/X11R6/{bin,lib/modules/input}
	make install || die
	dodoc {script/usbmouse,alps.patch,COMPATIBILITY,FILES,INSTALL{,.DE},LICENSE,NEWS,TODO,VERSION,README{,.alps}}
	# Stupid new daemon, didn't work for me because of shm issues
	exeinto /etc/init.d && newexe ${FILESDIR}/rc.init syndaemon
	insinto /etc/conf.d && newins ${FILESDIR}/rc.conf syndaemon
}
