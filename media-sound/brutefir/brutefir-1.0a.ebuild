# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/brutefir/brutefir-1.0a.ebuild,v 1.2 2004/08/28 18:14:24 dholm Exp $

IUSE=""

inherit eutils

DESCRIPTION="BruteFIR is a software convolution engine, a program for applying long FIR filters to multi-channel digital audio, either offline or in realtime."
HOMEPAGE="http://www.ludd.luth.se/~torger/brutefir.html"
SRC_URI="http://www.ludd.luth.se/~torger/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND="virtual/libc
	>=media-libs/alsa-lib-0.9.1
	media-sound/jack-audio-connection-kit
	>=dev-libs/fftw-3.0.0"

src_install() {

	mkdir -p ${D}/usr/bin
	mkdir -p ${D}/usr/lib/brutefir

	einstall DESTDIR=${D} \
		INSTALL_PREFIX=${D}/usr	|| die

	dodoc CHANGES README LICENSE

	insinto usr/share/brutefir
	doins xtc_config directpath.txt crosspath.txt massive_config bench1_config bench2_config bench3_config bench4_config bench5_config
}

pkg_postinst() {
	einfo Brutefir is a complicated piece of software. Please read the documentation first!
	einfo You can find documentation here: http://www.ludd.luth.se/~torger/brutefir.html
	einfo Example config files are in /usr/share/brutefir
}
