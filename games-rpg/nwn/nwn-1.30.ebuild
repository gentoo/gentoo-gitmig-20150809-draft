# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwn/nwn-1.30.ebuild,v 1.1 2003/09/10 06:26:50 vapier Exp $

inherit games

DESCRIPTION="Never Winter Nights"
HOMEPAGE="http://nwn.bioware.com/downloads/linuxclient.html"
SRC_URI="ftp://jeuxlinux.com/bioware/Neverwinter_Nights/nwclient129.tar.gz
	nowin? ( ftp://jeuxlinux.com/bioware/Neverwinter_Nights/nwresources129.tar.gz )
	http://nwdownloads.bioware.com/neverwinternights/linux/130/linuxclientupdate129to130.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE="nowin"
RESTRICT="fetch nostrip nomirror"

RDEPEND="virtual/x11
	opengl? ( virtual/opengl )
	>=media-libs/libsdl-1.2.5"

S=${WORKDIR}/nwn

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack nwclient129.tar.gz
	cd ${WORKDIR}
	use nowin && unpack nwresources129.tar.gz
	cd ${S}
	unpack linuxclientupdate129to130.tar.gz
}

src_install() {
	dodir ${GAMES_PREFIX_OPT}
	sed \
		-e "s:GENTOO_USER:${GAMES_USER}:" \
		-e "s:GENTOO_GROUP:${GAMES_GROUP}:" \
		-e "s:GENTOO_DIR:${GAMES_PREFIX_OPT}:" \
		${FILESDIR}/${P}-fixinstall > ${WORKDIR}/nwn/fixinstall
	mv ${WORKDIR}/nwn ${D}/${GAMES_PREFIX_OPT}
	dogamesbin ${FILESDIR}/nwn
	prepgamesdirs
}

pkg_postinst() {
	if [ ! `use nowin` ] ; then
		einfo "The NWN linux client is now installed."
		einfo "Proceed with the following steps in order to get it working:"
		einfo "1) Copy the following directories/files from your installed and"
		einfo "   patched (${PV}) Never Winter Nights to ${GAMES_PREFIX_OPT}/nwn:"
		einfo "    ambient/"
		einfo "    data/"
		einfo "    dmvault/"
		einfo "    hak/"
		einfo "    localvault/"
		einfo "    modules/"
		einfo "    music/"
		einfo "    nwm/"
		einfo "    override/"
		einfo "    portraits/"
		einfo "    saves/"
		einfo "    servervault/"
		einfo "    texturepacks/"
		einfo "    chitin.key"
		einfo "    patch.key"
		einfo "    dialog.tlk"
		einfo "    dialogF.tlk (French, German, Italian, and Spanish)"
		einfo "2) Chown and chmod the files with the following commands"
		einfo "    chown -R ${GAMES_USER}.${GAMES_GROUP} ${GAMES_PREFIX_OPT}/nwn"
		einfo "    chmod -R g+rwX ${GAMES_PREFIX_OPT}/nwn"
		einfo "3) Run ${GAMES_PREFIX_OPT}/nwn/fixinstall as root"
		einfo "4) Make sure that you are in group ${GAMES_GROUP}"
		einfo "5) Use ${GAMES_PREFIX_OPT}/nwn/nwn to run the game"
		echo
		einfo "Or try emerging with USE=nowin"
	fi
	games_pkg_postinst
}
