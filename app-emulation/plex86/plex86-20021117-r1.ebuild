# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/plex86/plex86-20021117-r1.ebuild,v 1.1 2005/08/20 17:38:44 vanquirius Exp $

inherit eutils

DESCRIPTION="Plex86 is THE opensource free-software alternative for VMWare, VirtualPC, and other IA-32 on IA-32 \"Virtual PC products.\""
HOMEPAGE="http://savannah.gnu.org/projects/plex86/ http://sourceforge.net/projects/plex86/"
SRC_URI="http://savannah.nongnu.org/download/plex86/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="X sdl"

RDEPEND=">=sys-libs/ncurses-5.2-r7
	X? ( virtual/x11 )
	sdl? ( >=media-libs/libsdl-1.2.4 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}; cd ${S}

	# fix malign warnings
	sed -e 's:malign:falign:g' \
		-i kernel/{.,dt,iodev,emulation}/Makefile.in || die

	# fix typo (bug submitted)
	sed -i \
		-e s/'inclide'/'include'/ user/plugins/bochs/iodev/eth_fbsd.cc \
			|| die "sed eth_fbsd.cc failed"

	# DANGEROUS patch to allow compilation
	epatch ${FILESDIR}/${P}-hacks.patch
}

src_compile() {
	MY_CONF="--with-Linux --enable-cdrom --enable-split-hd --enable-pci --enable-vbe --enable-sb16=linux --enable-instrumentation"
	# --enable-ne2000 not working at the moment

	MY_GUI="curses"
	use X && MY_GUI="x"
	use sdl && MY_GUI="sdl"
	use sdl && export SDL_CFLAGS="`sdl-config --cflags`"

	use X && MY_CONF="${MY_CONF} --with-x --with-linux-source=/usr/src/linux"
	MY_CONF="${MY_CONF} --with-gui=${MY_GUI}"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man ${MY_CONF} || die "./configure failed"

	emake || die "emake failed"
}

src_install() {
	#make DESTDIR=${D} install || die
	# for now just this:
	dodir /opt/${P}
	cp -r * ${D}/opt/${P} || die "cp failed"
}

pkg_postinst() {
	echo
	ewarn "This code is EXTREMELY EXPERIMENTAL, and may well result in a"
	ewarn "SYSTEM CRASH, and who knows what other ill effects.  RUN THIS"
	ewarn "SOFTWARE AT YOUR OWN RISK.  As a precaution, do not attempt to"
	ewarn "run this software on a system with important data on it, and"
	ewarn "make liberal use of the sync command!  Expect to have to use"
	ewarn "the power button."
	echo
	einfo "Contact me (lordvan@lordvan.com) if you encounter any problems."
	echo
}
