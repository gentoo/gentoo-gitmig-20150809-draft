# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwn/nwn-1.65.ebuild,v 1.1 2004/12/30 09:06:24 vapier Exp $

inherit games

UPDATEVER=${PV//.}
DESCRIPTION="Neverwinter Nights"
HOMEPAGE="http://nwn.bioware.com/downloads/linuxclient.html"
SRC_URI="http://nwdownloads.bioware.com/neverwinternights/linux/129/nwclient129.tar.gz
	nowin? ( http://www.tucows.iinet.net/pub/games/neverwinter/linux/nwresources129.tar.gz )
	http://content.bioware.com/neverwinternights/linux/${UPDATEVER}/linuxclientupdate1xxto${UPDATEVER}eng.tar.gz
	http://nwdownloads.bioware.com/neverwinternights/patch/dialog/english/NWNEnglish${PV}dialog.zip"

LICENSE="NWN-EULA"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nowin"
RESTRICT="nostrip nomirror"

RDEPEND="virtual/x11
	virtual/opengl
	>=media-libs/libsdl-1.2.5
	amd64? ( app-emulation/emul-linux-x86-baselibs )"

S="${WORKDIR}/nwn"

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack nwclient129.tar.gz
	cd ${WORKDIR}
	use nowin && unpack nwresources129.tar.gz
	cd ${S}
	rm -rf override/*
	unpack linuxclientupdate1xxto${UPDATEVER}eng.tar.gz
	unpack NWNEnglish${PV}dialog.zip
}

src_install() {
	dodir ${GAMES_PREFIX_OPT}
	sed \
		-e "s:GENTOO_USER:${GAMES_USER}:" \
		-e "s:GENTOO_GROUP:${GAMES_GROUP}:" \
		-e "s:GENTOO_DIR:${GAMES_PREFIX_OPT}:" \
		${FILESDIR}/${P}-fixinstall > ${WORKDIR}/nwn/fixinstall
	mv ${S} ${D}/${GAMES_PREFIX_OPT}
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/nwn.png
	dogamesbin ${FILESDIR}/nwn
	dosed "s:GENTOO_DIR:${GAMES_PREFIX_OPT}:" ${GAMES_BINDIR}/nwn
	make_desktop_entry nwn "Neverwinter Nights" nwn.png
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if ! use nowin ; then
		einfo "The NWN linux client is now installed."
		einfo "Proceed with the following steps in order to get it working:"
		einfo "1) Copy the following directories/files from your installed and"
		einfo "   patched (${PV}) Neverwinter Nights to ${GAMES_PREFIX_OPT}/nwn:"
		einfo "    ambient/"
		einfo "    data/ (all files except for patch.bif)"
		einfo "    dmvault/"
		einfo "    hak/"
		einfo "    localvault/"
		einfo "    modules/"
		einfo "    music/"
		einfo "    override/"
		einfo "    portraits/"
		einfo "    saves/"
		einfo "    servervault/"
		einfo "    texturepacks/"
		einfo "    chitin.key"
		einfo "2) Chown and chmod the files with the following commands"
		einfo "    chown -R ${GAMES_USER}:${GAMES_GROUP} ${GAMES_PREFIX_OPT}/nwn"
		einfo "    chmod -R g+rwX ${GAMES_PREFIX_OPT}/nwn"
		einfo "3) Run ${GAMES_PREFIX_OPT}/nwn/fixinstall as root"
		einfo "4) Make sure that you are in group ${GAMES_GROUP}"
		einfo "5) Use ${GAMES_PREFIX_OPT}/nwn/nwn to run the game"
		echo
		einfo "Or try emerging with USE=nowin"
	else
		einfo "The NWN linux client is now installed."
		einfo "Proceed with the following step in order to get it working:"
		einfo "Run ${GAMES_PREFIX_OPT}/nwn/fixinstall as root"
	fi
}
