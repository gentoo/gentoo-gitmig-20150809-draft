# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libnjb/libnjb-2.2.ebuild,v 1.2 2005/08/13 12:33:29 axxo Exp $

inherit eutils


DESCRIPTION="libnjb is a C library and API for communicating with the Creative Nomad JukeBox digital audio player under BSD and Linux."
HOMEPAGE="http://libnjb.sourceforge.net/"
SRC_URI="mirror://sourceforge/libnjb/${P}.tar.gz"
IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

DEPEND=">=dev-libs/libusb-0.1.7"

S=${WORKDIR}/${PN}-${PV/_*}

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i "s:SUBDIRS = src sample doc:SUBDIRS = src doc:" Makefile.in || die "sed failed"
}

src_compile() {
	econf --enable-hotplugging || die "./configure failed."
	emake -j1 || die "make failed."
}

src_install() {
	make DESTDIR=${D} install || die "failed to install"

	# Backwards compatability
	dosym libnjb.so /usr/$(get_libdir)/libnjb.so.0

	dodoc FAQ INSTALL CHANGES README
	exeinto /etc/hotplug/usb/
	doexe nomadjukebox
}
