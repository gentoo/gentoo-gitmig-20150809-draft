# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libnjb/libnjb-1.2.ebuild,v 1.4 2004/10/08 09:46:58 eradicator Exp $

IUSE=""

inherit eutils

DESCRIPTION="libnjb is a C library and API for communicating with the Creative Nomad JukeBox digital audio player under BSD and Linux."
HOMEPAGE="http://libnjb.sourceforge.net/"
SRC_URI="mirror://sourceforge/libnjb/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND=">=dev-libs/libusb-0.1.7"

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i "s:all\: lib samples filemodes:all\: lib filemodes:g" Makefile.in
	epatch ${FILESDIR}/${P}-gentoo-multilib.patch
}

src_compile() {
	econf || die "./configure failed."
	emake -j1 || die "make failed."
}

src_install() {
	# borks make DESTDIR=${D} install || die
	einstall || die

	# Backwards compatability
	dosym libnjb.so /usr/$(get_libdir)/libnjb.so.0
	prepalldocs
	dodoc FAQ LICENSE INSTALL CHANGES README
	exeinto /etc/hotplug/usb/
	doexe ${FILESDIR}/nomadjukebox
	cp ${ROOT}/etc/hotplug/usb.usermap ${D}/etc/hotplug/usb.usermap
	cat nomad.usermap >> ${D}/etc/hotplug/usb.usermap
}
