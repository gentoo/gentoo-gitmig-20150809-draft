# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libnjb/libnjb-2.0_pre20050208.ebuild,v 1.1 2005/02/11 00:32:19 axxo Exp $

inherit eutils

MY_PV=${PV/_pre/-0.}

DESCRIPTION="libnjb is a C library and API for communicating with the Creative Nomad JukeBox digital audio player under BSD and Linux."
HOMEPAGE="http://libnjb.sourceforge.net/"
SRC_URI="mirror://sourceforge/libnjb/${PN}-${MY_PV}.tar.gz"
IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=dev-libs/libusb-0.1.7"

S=${WORKDIR}/${PN}-${PV/_*}

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
