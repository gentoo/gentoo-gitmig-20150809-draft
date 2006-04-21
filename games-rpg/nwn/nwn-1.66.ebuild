# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwn/nwn-1.66.ebuild,v 1.15 2006/04/21 14:28:05 wolf31o2 Exp $

inherit eutils games

UPDATEVER=${PV//.}
PATCH_URL_BASE=http://content.bioware.com/neverwinternights/linux/${UPDATEVER}/
DIALOG_URL_BASE=http://nwdownloads.bioware.com/neverwinternights/patch/dialog/
PACKAGE_NAME=_linuxclient${UPDATEVER}_orig.tar.gz

DESCRIPTION="Neverwinter Nights"
HOMEPAGE="http://nwn.bioware.com/downloads/linuxclient.html"
SRC_URI="http://nwdownloads.bioware.com/neverwinternights/linux/129/nwclient129.tar.gz
	linguas_fr? ( ${PATCH_URL_BASE}French${PACKAGE_NAME} ${DIALOG_URL_BASE}/french/NWNFrench${PV}dialog.zip ftp://jeuxlinux.com/bioware/Neverwinter_Nights/nwfrench129.tar.gz )
	linguas_it? ( ${PATCH_URL_BASE}Italian${PACKAGE_NAME} ${DIALOG_URL_BASE}/italian/NWNItalian${PV}dialog.zip http://nwdownloads.bioware.com/neverwinternights/linux/129/nwitalian129.tar.gz )
	linguas_es? ( ${PATCH_URL_BASE}Spanish${PACKAGE_NAME} ${DIALOG_URL_BASE}/spanish/NWNSpanish${PV}dialog.zip http://nwdownloads.bioware.com/neverwinternights/linux/129/nwspanish129.tar.gz )
	linguas_de? ( ${PATCH_URL_BASE}German${PACKAGE_NAME} ${DIALOG_URL_BASE}/german/NWNGerman${PV}dialog.zip http://xfer06.fileplanet.com/%5E389272944/082003/nwgerman129.tar.gz )
	!linguas_de? ( !linguas_fr? ( !linguas_es? ( !linguas_it? (
		${PATCH_URL_BASE}English${PACKAGE_NAME} ${DIALOG_URL_BASE}/english/NWNEnglish${PV}dialog.zip
	) ) ) )
	nowin? ( http://bsd.mikulas.com/nwresources129.tar.gz
	http://163.22.12.40/FreeBSD/distfiles/nwresources129.tar.gz
	ftp://jeuxlinux.com/bioware/Neverwinter_Nights/nwresources129.tar.gz )
	mirror://gentoo/nwn.png
	http://dev.gentoo.org/~wolf31o2/sources/dump/nwn.png"

LICENSE="NWN-EULA"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nowin"
RESTRICT="mirror strip"

RDEPEND="virtual/opengl
	>=media-libs/libsdl-1.2.5
	x86? (
		=virtual/libstdc++-3.3
		|| (
			(
				x11-libs/libXext
				x11-libs/libX11 )
			virtual/x11 ) )
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-xlibs )"
DEPEND="app-arch/unzip"

S="${WORKDIR}/nwn"
dir="${GAMES_PREFIX_OPT}/${PN}"

pkg_setup() {
#	use nocd && \
#	cdrom_get_cds \
#		Data_Shared.zip \
#		disk2.zip \
#		disk3.zip \
#		disk4.zip
#	einfo "To download nwgerman129.tar.gz you need a gamespy account"
	games_pkg_setup
}

src_unpack() {
	mkdir -p "${S}"
	cd "${S}"
	unpack nwclient129.tar.gz
	rm -rf override/*
	# the following is so ugly, please pretend it doesnt exist
	declare -a Aarray=(${A})
	use nowin && if [ "${#Aarray[*]}" == "5" ]
	then
		cd "${WORKDIR}"
		unpack ${Aarray[3]}
		cd "${S}"
	fi
	unpack ${Aarray[1]}
	unpack ${Aarray[2]}
}

src_install() {
	dodir ${GAMES_PREFIX_OPT}
	sed \
		-e "s:GENTOO_USER:${GAMES_USER}:" \
		-e "s:GENTOO_GROUP:${GAMES_GROUP}:" \
		-e "s:GENTOO_DIR:${GAMES_PREFIX_OPT}:" \
		${FILESDIR}/fixinstall > ${WORKDIR}/nwn/fixinstall
	mv ${S} ${D}/${GAMES_PREFIX_OPT}
	doicon ${DISTDIR}/nwn.png
	games_make_wrapper nwn ./nwn "${dir}" "${dir}"
	make_desktop_entry nwn "Neverwinter Nights" nwn.png
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "There is a possible color problem with Neverwinter Nights.  There is"
	einfo "not currently a patch for this issue.  For more information, you can"
	einfo "go to http://bugs.gentoo.org/118728 or"
	einfo "http://nwn.bioware.com/forums/myviewtopic.html?topic=461888&forum=72"
	echo
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
