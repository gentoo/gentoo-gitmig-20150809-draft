# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libclxclient/libclxclient-1.0.0.ebuild,v 1.1 2004/10/09 22:14:49 trapni Exp $

inherit eutils

DESCRIPTION="An audio library by Fons Adriaensen <fons.adriaensen@skynet.be>"
HOMEPAGE="http://users.skynet.be/solaris/linuxaudio"
SRC_URI="http://users.skynet.be/solaris/linuxaudio/downloads/clxclient-${PV}.tar.bz2"
RESTRICT=""
IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

S=${WORKDIR}/clxclient-${PV}

#first two for WANT_AUTOMAKE/CONF
DEPEND="
	>=sys-devel/autoconf-2.58
	>=sys-devel/automake-1.7.2
	virtual/glibc
	virtual/x11
	>=media-libs/libclthreads-1.0.0
"

src_compile() {
	epatch "${FILESDIR}/${P}-makefile.patch" || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
