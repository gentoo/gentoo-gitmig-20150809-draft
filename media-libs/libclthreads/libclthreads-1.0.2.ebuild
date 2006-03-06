# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libclthreads/libclthreads-1.0.2.ebuild,v 1.4 2006/03/06 14:41:16 flameeyes Exp $

IUSE=""

inherit eutils multilib toolchain-funcs

MY_P="clthreads-${PV}"

S="${WORKDIR}/${MY_P}"

DESCRIPTION="An audio library by Fons Adriaensen <fons.adriaensen@skynet.be>"
HOMEPAGE="http://users.skynet.be/solaris/linuxaudio"
SRC_URI="http://users.skynet.be/solaris/linuxaudio/downloads/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	tc-export CC CXX
	emake || die "emake failed"
}

src_install() {
	make CLTHREADS_LIBDIR="/usr/$(get_libdir)" DESTDIR="${D}" install || die "make install failed"
}
