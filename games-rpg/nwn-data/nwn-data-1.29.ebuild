# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwn-data/nwn-data-1.29.ebuild,v 1.1 2005/09/21 00:11:30 wolf31o2 Exp $

inherit eutils games

MY_PV=${PV//.}

DESCRIPTION="Neverwinter Nights Data Files"
HOMEPAGE="http://nwn.bioware.com/downloads/linuxclient.html"
SRC_URI="http://nwdownloads.bioware.com/neverwinternights/linux/${MY_PV}/nwclient${MY_PV}.tar.gz
	linguas_fr? (
		ftp://jeuxlinux.com/bioware/Neverwinter_Nights/nwfrench${MY_PV}.tar.gz )
	linguas_it? (
		http://nwdownloads.bioware.com/neverwinternights/linux/${MY_PV}/nwitalian${MY_PV}.tar.gz )
	linguas_es? (
		http://nwdownloads.bioware.com/neverwinternights/linux/${MY_PV}/nwspanish${MY_PV}.tar.gz )
	linguas_de? (
		http://xfer06.fileplanet.com/%5E389272944/082003/nwgerman${MY_PV}.tar.gz )
	nowin? (
		http://bsd.mikulas.com/nwresources${MY_PV}.tar.gz
		http://163.22.12.40/FreeBSD/distfiles/nwresources${MY_PV}.tar.gz
		ftp://jeuxlinux.com/bioware/Neverwinter_Nights/nwresources${MY_PV}.tar.gz )"

LICENSE="NWN-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nowin sou hou"
RESTRICT="nostrip nomirror"

RDEPEND="virtual/x11
	virtual/opengl
	>=media-libs/libsdl-1.2.5
	amd64? ( app-emulation/emul-linux-x86-baselibs )"

S="${WORKDIR}/nwn"
dir="${GAMES_PREFIX_OPT}/${PN/-data}"
Ddir="${D}/${dir}"

pkg_setup() {
	if use sou && use hou
	then
		cdrom_get_cds NWNSoUInstallGuide.rtf \
			ArcadeInstallNWNXP213f.EXE
	elif use sou
	then
		cdrom_get_cds NWNSoUInstallGuide.rtf
	elif use hou
	then
		cdrom_get_cds ArcadeInstallNWNXP213f.EXE
	fi
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
	use nowin && if [ "${#Aarray[*]}" == "3" ]; then
		unpack ${Aarray[1]}
	fi
	if use sou
	then
		unzip -o ${CDROM_ROOT}/Data_Shared.zip
		unzip -o ${CDROM_ROOT}/Language_data.zip
		unzip -o ${CDROM_ROOT}/Language_update.zip
		unzip -o ${CDROM_ROOT}/Data_Linux.zip
		rm -f data/patch.bif patch.key
	fi
	if use hou
	then
		if use sou && use hou
		then
			rm -f xp1patch.key data/xp1patch.bif override/*
			cdrom_load_next_cd
		fi
		rm -f data/patch.bif patch.key
		unzip -o ${CDROM_ROOT}/Data_Shared.zip
		unzip -o ${CDROM_ROOT}/Language_data.zip
		unzip -o ${CDROM_ROOT}/Language_update.zip
	fi
}

src_install() {
	dodir ${dir}
	# Since the movies don't play anyway, we'll remove them
	rm -rf ${S}/movies
	mkdir -p ${S}/dmvault ${S}/hak ${S}/portraits
	rm -rf ${S}/dialog.tlk ${S}/dialog.TLK ${S}/dmclient ${S}/nwmain \
		${S}/nwserver  ${S}/nwm/* ${S}/SDL-1.2.5 ${S}/fixinstall
	mv ${S}/* ${Ddir}
	keepdir ${dir}/servervault
	keepdir ${dir}/scripttemplates
	keepdir ${dir}/saves
	keepdir ${dir}/portraits
	keepdir ${dir}/hak
	cd ${Ddir}
	for d in ambient data dmvault hak localvault music override portraits
	do
		cd ${d}
		for f in $(find . -name '*.*') ; do
			lcf=$(echo ${f} | tr [:upper:] [:lower:])
			if [ ${f} != ${lcf} ] && [ -f ${f} ]
			then
				mv ${f} $(echo ${f} | tr [:upper:] [:lower:])
			fi
		done
		cd ${Ddir}
	done
	if ! use sou && ! use hou
	then
		chmod a-x ${Ddir}/data/patch.bif chmod a-x${Ddir}/patch.key
	fi
	doicon ${FILESDIR}/nwn.png
	prepgamesdirs
	chmod -R g+rwX ${Ddir}/saves ${Ddir}/localvault ${Ddir}/dmvault \
		|| die "could not chmod"
	chmod g+rwX ${Ddir} || die "could not chmod"
}

pkg_postinst() {
	games_pkg_postinst
	if ! use nowin ; then
		einfo "The NWN linux client data is now installed."
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
		einfo "    chown -R ${GAMES_USER}:${GAMES_GROUP} ${dir}"
		einfo "    chmod -R g+rwX ${dir}"
		einfo "3) Run ${dir}/fixinstall as root"
		einfo "4) Make sure that you are in group ${GAMES_GROUP}"
		echo
		einfo "Or try emerging with USE=nowin"
	else
		einfo "The NWN linux client data is now installed."
	fi
	echo
	einfo "This is only the data portion, you will also need games-rpg/nwn to"
	einfo "play Neverwinter Nights."
	echo
}
