# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/plex86/plex86-20021117.ebuild,v 1.7 2004/02/20 06:08:34 mr_bones_ Exp $

DESCRIPTION="Plex86 is THE opensource free-software alternative for VMWare, VirtualPC, and other IA-32 on IA-32 \"Virtual PC products.\""
HOMEPAGE="http://savannah.gnu.org/projects/plex86/"
LICENSE="LGPL-2.1"
SRC_URI="http://savannah.nongnu.org/download/plex86/${P}.tar.bz2"
SLOT="0"
KEYWORDS="x86"
IUSE="X sdl"
RDEPEND=">=sys-libs/ncurses-5.2-r7
	X? ( >=x11-base/xfree-4.2.0 )
	sdl? ( >=media-libs/libsdl-1.2.4 )"
DEPEND="${RDEPEND}"
DEPEND=""
S="${WORKDIR}/${P}"

src_compile() {
	MY_CONF="--with-Linux --enable-cdrom --enable-split-hd --enable-pci --enable-vbe --enable-sb16=linux --enable-instrumentation"
	# --enable-ne2000 not working at the moment

	MY_GUI="curses"
	use X && MY_GUI="x"
	use sdl && MY_GUI="sdl"
	use sdl && export SDL_CFLAGS="`sdl-config --cflags`"

	use X && MY_CONF="${MY_CONF} --with-x --with-linux-source=/usr/src/linux"
	MY_CONF="${MY_CONF} --with-gui=${MY_GUI}"

	# fix typo (bug submitted)
	mv user/plugins/bochs/iodev/eth_fbsd.cc user/plugins/bochs/iodev/eth_fbsd.cc_orig
	sed s/'inclide'/'include'/ user/plugins/bochs/iodev/eth_fbsd.cc_orig > user/plugins/bochs/iodev/eth_fbsd.cc

	./configure \
	--host=${CHOST} \
	--prefix=/usr \
	--infodir=/usr/share/info \
	--mandir=/usr/share/man ${MY_CONF} || die "./configure failed"

	make || die
}

src_install() {
	#make DESTDIR=${D} install || die
	# for now just this:
	dodir /opt/${P}
	cp -r * ${D}/opt/${P}
}

pkg_postinst() {
	echo
	einfo ",-----------------------------------------------------------------."
	einfo "| IMPORTANT NOTICE                                                |"
	einfo "|-----------------------------------------------------------------|"
	einfo "| This code is EXTREMELY EXPERIMENTAL, and may well result in a   |"
	einfo "| SYSTEM CRASH, and who knows what other ill effects.  RUN THIS   |"
	einfo "| SOFTWARE AT YOUR OWN RISK.  As a precaution, do not attempt to  |"
	einfo "| run this software on a system with important data on it, and    |"
	einfo "| make liberal use of the sync command!  Expect to have to use    |"
	einfo "| the power button.                                               |"
	einfo "\`-----------------------------------------------------------------'"
	echo
	einfo "Contact me (lordvan@lordvan.com) if you encounter any problems."
	echo
}
