# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwn/nwn-1.62.ebuild,v 1.10 2004/07/18 03:47:57 vapier Exp $

inherit games

UPDATEVER=${PV//.}
DESCRIPTION="Never Winter Nights"
HOMEPAGE="http://nwn.bioware.com/downloads/linuxclient.html"
SRC_URI="http://nwdownloads.bioware.com/neverwinternights/linux/129/nwclient129.tar.gz
	nowin? ( ftp://jeuxlinux.com/bioware/Neverwinter_Nights/nwresources129.tar.gz )
	http://nwdownloads.bioware.com/neverwinternights/linux/${UPDATEVER}/linuxclientupdate129to${UPDATEVER}eng.tar.gz"

LICENSE="NWN-EULA"
SLOT="0"
KEYWORDS="x86 ~amd64"
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
	unpack linuxclientupdate129to${UPDATEVER}eng.tar.gz
}

src_install() {
	dodir ${GAMES_PREFIX_OPT}
	sed \
		-e "s:GENTOO_USER:${GAMES_USER}:" \
		-e "s:GENTOO_GROUP:${GAMES_GROUP}:" \
		-e "s:GENTOO_DIR:${GAMES_PREFIX_OPT}:" \
		${FILESDIR}/${P}-fixinstall > ${WORKDIR}/nwn/fixinstall
	mv ${WORKDIR}/nwn ${D}/${GAMES_PREFIX_OPT}
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/nwn.png
	dogamesbin ${FILESDIR}/nwn
	dosed "s:GENTOO_DIR:${GAMES_PREFIX_OPT}:" ${GAMES_BINDIR}/nwn
	make_desktop_entry nwn "Never Winter Nights" nwn.png
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if ! use nowin ; then
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
