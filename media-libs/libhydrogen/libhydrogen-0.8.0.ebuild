# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libhydrogen/libhydrogen-0.8.0.ebuild,v 1.8 2004/01/30 05:58:33 drobbins Exp $

inherit libtool

DESCRIPTION="Linux Drum Machine - Libary"
HOMEPAGE="http://hydrogen.sourceforge.net"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/hydrogen/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

S="${WORKDIR}/${P}"

RDEPEND="virtual/x11 \
	>=media-libs/audiofile-0.2.3 \
	alsa? ( media-libs/alsa-lib ) \
	virtual/jack"

DEPEND="$RDEPEND >=sys-devel/autoconf-2.58"

src_compile() {
	einfo "Reconfiguring..."
	export WANT_AUTOCONF=2.5
	aclocal
	autoconf
	automake

	elibtoolize
	sed -i "s/driver = new JackDriver(audioEngine_process);/driver = new JackDriver((JackProcessCallback) audioEngine_process);/" ${S}/src/Hydrogen.cpp

	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog FAQ README TODO
}
