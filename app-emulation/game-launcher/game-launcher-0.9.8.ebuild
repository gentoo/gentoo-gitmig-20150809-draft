# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/game-launcher/game-launcher-0.9.8.ebuild,v 1.3 2003/03/11 20:50:08 seemant Exp $

DESCRIPTION="Game Launcher is a cross platform, universal front end for emulators.It has been known to work with MAME, Nesticle, RockNES, zSNES, snes9x, Callus, Stella, z26 and Genecyst."
HOMEPAGE="http://www.dribin.org/dave/game_launcher/"
SRC_URI="mirror://sourceforge/glaunch/gl098s.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=media-libs/allegro-4.0.0
        >=media-libs/loadpng-0.11
        >=media-libs/allegromp3-2.0.2
        >=media-libs/allegttf-2.0
	>=media-libs/libpng-1.2.4
        >=sys-libs/zlib-1.1.4
        >=app-arch/unzip-5.50
        >=app-text/recode-3.6" 

RDEPEND=">=media-libs/allegro-4.0.0
        >=media-libs/loadpng-0.11
        >=media-libs/allegromp3-2.0.2
        >=media-libs/allegttf-2.0
	>=media-libs/libpng-1.2.4
        >=sys-libs/zlib-1.1.4"

# Source directory; the dir where the sources can be found (automatically
# unpacked) inside ${WORKDIR}.  S will get a default setting of ${WORKDIR}/${P}
# if you omit this line.
S="${WORKDIR}/glaunch"

src_compile() {
    cd ${S}
    # got to recode this cuz gcc complains about CF+LF after a '\'
    recode /CR mamescan/main.cc \
	mamescan/scanner.cc \
	mamescan/gamelist.cc \
	model/emumgr.cc \
	control/emumenu.cc \
	control/launcher.cc \
	control/bgctrl.cc
    # set TARGET (maybe set compile options here later too)
    mv common.mk common.mk_orig
    sed s/'TARGET\(.*\)= MINGW'/'#TARGET\1= MINGW'/ common.mk_orig | sed s/'#TARGET\(.*\)= UNIX'/'TARGET\1= UNIX'/ > common.mk
    emake || die
	
}

src_install() {
    dodir /opt/${P}
#    cp glaunch _gl32 glaunch.dat glaunch.cfg slicker.ttf mamescan.exe ${D}/opt/${P}
    cp -r ${S}/* ${D}/opt/${P}  # doinst can't do recursive
}

pkg_postinst() {
    echo
    einfo "WARNING: Some files in /opt/${P} are world writeable!!!"
    einfo "Because of the design that can't be changed easily."
    einfo "You can add a new group and then change the permissions."
    einfo "Members of that group then can run it."
    echo
}
