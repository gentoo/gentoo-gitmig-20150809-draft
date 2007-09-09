# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/synaptics/synaptics-0.14.6.ebuild,v 1.8 2007/09/09 20:20:15 genstef Exp $

inherit toolchain-funcs eutils

IUSE=""

DESCRIPTION="Driver for Synaptics touchpads"
HOMEPAGE="http://w1.894.telia.com/~u89404340/touchpad/"
SRC_URI="http://w1.894.telia.com/~u89404340/touchpad/files/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ppc64 x86"

RDEPEND="x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-base/xorg-server
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A} ; cd ${S}

	# Switch up the CC and CFLAGS stuff.
	sed -i \
		-e "s:CC = gcc:CC = $(tc-getCC):g" \
		-e "s:CDEBUGFLAGS = -O2:CDEBUGFLAGS = ${CFLAGS}:g" \
		${S}/Makefile
	epatch ${FILESDIR}/synaptics_input_api.diff
}

src_compile() {
	emake || die
}

src_install() {
	make \
		DESTDIR=${D} \
		PREFIX=/usr \
		MANDIR=${D}/usr/share/man \
		install || die

	dodoc script/usbmouse script/usbhid alps.patch trouble-shooting.txt
	dodoc COMPATIBILITY FILES INSTALL* LICENSE NEWS TODO README*

	# Stupid new daemon, didn't work for me because of shm issues
	newinitd ${FILESDIR}/rc.init syndaemon
	newconfd ${FILESDIR}/rc.conf syndaemon
}
