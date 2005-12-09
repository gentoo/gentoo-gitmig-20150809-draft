# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/synaptics/synaptics-0.14.4.ebuild,v 1.1 2005/12/09 15:23:11 seemant Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Driver for Synaptics touchpads"
HOMEPAGE="http://w1.894.telia.com/~u89404340/touchpad/"
SRC_URI="http://w1.894.telia.com/~u89404340/touchpad/files/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dlloader"
RDEPEND="virtual/x11"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${P}-makefile.patch

	# Switch up the CC and CFLAGS stuff.
	sed -i \
		-e "s:CC = gcc:CC = $(tc-getCC):g" \
		-e "s:CDEBUGFLAGS = -O2:CDEBUGFLAGS = ${CFLAGS}:g" \
		${S}/Makefile
}

src_compile() {
	emake || die
	if use dlloader || has_version ">=x11-base/xorg-x11-6.8.99.15"
	then
		$(tc-getCC) -shared -nostdlib -o synaptics_drv.so synaptics_drv.o -Bstatic -lgcc
	fi
}

src_install() {
	# Yes, they got the DESTDIR stuff going. And there was much rejoicing.
	make DESTDIR=${D} install || die
	if use dlloader || has_version ">=x11-base/xorg-x11-6.8.99.15"
	then
		exeinto /usr/$(get_libdir)/xorg/modules/input
		doexe synaptics_drv.so
		rm ${D}/usr/$(get_libdir)/modules/input/synaptics_drv.o
	fi

	dodoc script/usbmouse alps.patch
	dodoc COMPATIBILITY FILES INSTALL* LICENSE NEWS TODO README*

	# Stupid new daemon, didn't work for me because of shm issues
	exeinto /etc/init.d && newexe ${FILESDIR}/rc.init syndaemon
	insinto /etc/conf.d && newins ${FILESDIR}/rc.conf syndaemon
}
