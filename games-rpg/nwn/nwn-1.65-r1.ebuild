# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwn/nwn-1.65-r1.ebuild,v 1.2 2005/01/30 04:22:09 vapier Exp $

inherit games eutils

UPDATEVER=${PV//.}
PATCH_URL_BASE=http://content.bioware.com/neverwinternights/linux/${UPDATEVER}/linuxclientupdate1xxto${UPDATEVER}
DIALOG_URL_BASE=http://nwdownloads.bioware.com/neverwinternights/patch/dialog/

DESCRIPTION="Neverwinter Nights"
HOMEPAGE="http://nwn.bioware.com/downloads/linuxclient.html"
SRC_URI="http://nwdownloads.bioware.com/neverwinternights/linux/129/nwclient129.tar.gz
	linguas_fr? ( ${PATCH_URL_BASE}fre.tar.gz ${DIALOG_URL_BASE}/french/NWNFrench${PV}dialog.zip )
	linguas_de? ( ${PATCH_URL_BASE}ger.tar.gz ${DIALOG_URL_BASE}/german/NWNGerman${PV}dialog.zip )
	linguas_it? ( ${PATCH_URL_BASE}ita.tar.gz ${DIALOG_URL_BASE}/italian/NWNItalian${PV}dialog.zip )
	linguas_es? ( ${PATCH_URL_BASE}spa.tar.gz ${DIALOG_URL_BASE}/spanish/NWNSpanish${PV}dialog.zip )
	!linguas_de? ( !linguas_fr? ( !linguas_es? ( !linguas_it? (
		${PATCH_URL_BASE}eng.tar.gz ${DIALOG_URL_BASE}/english/NWNEnglish${PV}dialog.zip
	) ) ) )
	nowin? ( ftp://jeuxlinux.com/bioware/Neverwinter_Nights/nwresources129.tar.gz )"

LICENSE="NWN-EULA"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nowin" # nocd"
RESTRICT="nostrip nomirror"

RDEPEND="virtual/x11
	virtual/opengl
	>=media-libs/libsdl-1.2.5
	amd64? ( app-emulation/emul-linux-x86-baselibs )"

S="${WORKDIR}/nwn"

pkg_setup() {
#	use nocd && \
#	cdrom_get_cds \
#		Data_Shared.zip \
#		disk2.zip \
#		disk3.zip \
#		disk4.zip
	games_pkg_setup
}

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack nwclient129.tar.gz
	cd ${WORKDIR}
	use nowin && unpack nwresources129.tar.gz
	cd ${S}
	rm -rf override/*
	# the following is so ugly, please pretend it doesnt exist
	declare -a Aarray=(${A})
	unpack ${Aarray[1]}
	unpack ${Aarray[2]}
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
