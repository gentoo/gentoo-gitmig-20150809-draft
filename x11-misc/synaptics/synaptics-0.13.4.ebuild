# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/synaptics/synaptics-0.13.4.ebuild,v 1.1 2004/08/05 03:47:15 battousai Exp $

inherit eutils

# This ebuild overwrites synaptics files installed by <= xfree-4.3.0-r6
# and xfree-4.3.99.14 >= X >= xfree-4.3.99.8.

DESCRIPTION="Driver for Synaptics touchpads"
HOMEPAGE="http://w1.894.telia.com/~u89404340/touchpad/"
SRC_URI="http://w1.894.telia.com/~u89404340/touchpad/files/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND="|| ( x11-base/xorg-x11 >=x11-base/xfree-4.3.0-r6 )"
DEPEND=">=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Fixes runtime brokenness with amd64 (bug 50384)
	if [ "${ARCH}" == "amd64" ]
	then
		einfo "Patching for amd64 arch..."
		epatch ${FILESDIR}/${P}-amd64.patch
	fi

	# Put stuff into /usr/X11R6, also switch up the CC and CFLAGS stuff.
	sed -i -e "s:BINDIR = \\\$(DESTDIR)/usr/local/bin:BINDIR = ${D}/usr/X11R6/bin:g" ${S}/Makefile
	sed -i -e "s:CC = gcc:CC = ${CC}:g" ${S}/Makefile
	sed -i -e "s:CDEBUGFLAGS = -O2:CDEBUGFLAGS = ${CFLAGS}:g" ${S}/Makefile
	sed -i -e "s:MANDIR = .*:MANDIR = \\\$(DESTDIR)/usr/man/man1:" ${S}/Makefile
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
