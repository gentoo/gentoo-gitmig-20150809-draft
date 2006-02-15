# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/synaptics/synaptics-0.14.4-r2.ebuild,v 1.2 2006/02/15 22:30:02 corsair Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Driver for Synaptics touchpads"
HOMEPAGE="http://w1.894.telia.com/~u89404340/touchpad/"
SRC_URI="http://w1.894.telia.com/~u89404340/touchpad/files/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="dlloader"
RDEPEND="|| ( x11-libs/libXext virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-base/xorg-server virtual/x11 )
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${PF}-makefile.patch

	if use dlloader || has_version ">=x11-base/xorg-x11-6.8.99.15" || has_version ">=x11-base/xorg-server-0.99"
	then
		epatch ${FILESDIR}/${PF}-makefile-fpic.patch
	fi

	# Switch up the CC and CFLAGS stuff.
	sed -i \
		-e "s:CC = gcc:CC = $(tc-getCC):g" \
		-e "s:CDEBUGFLAGS = -O2:CDEBUGFLAGS = ${CFLAGS}:g" \
		${S}/Makefile
}

src_compile() {
	emake || die
	if use dlloader || has_version ">=x11-base/xorg-x11-6.8.99.15" || has_version ">=x11-base/xorg-server-0.99"
	then
		$(tc-getCC) -shared -nostdlib -o synaptics_drv.so synaptics_drv.o -Bstatic -lgcc
	fi
}

src_install() {
	make DESTDIR=${D} install || die
	if use dlloader || has_version ">=x11-base/xorg-x11-6.8.99.15" || has_version ">=x11-base/xorg-server-0.99"
	then
		if has_version ">=x11-base/xorg-x11-7.0" || has_version ">=x11-base/xorg-server-0.99"
		then
			exeinto /usr/$(get_libdir)/xorg/modules/input
			doexe synaptics_drv.so
		else
			exeinto /usr/$(get_libdir)/modules/input
			doexe synaptics_drv.so
		fi
		rm ${D}/usr/$(get_libdir)/modules/input/synaptics_drv.o
	fi

	dodoc script/usbmouse alps.patch
	dodoc COMPATIBILITY FILES INSTALL* LICENSE NEWS TODO README*

	# Stupid new daemon, didn't work for me because of shm issues
	newinitd ${FILESDIR}/rc.init syndaemon
	newconfd ${FILESDIR}/rc.conf syndaemon
}
