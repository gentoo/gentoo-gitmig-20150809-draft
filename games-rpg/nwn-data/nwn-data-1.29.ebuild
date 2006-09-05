# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwn-data/nwn-data-1.29.ebuild,v 1.19 2006/09/05 20:59:26 wolf31o2 Exp $

inherit eutils games

MY_PV=${PV//.}

DESCRIPTION="Neverwinter Nights Data Files"
HOMEPAGE="http://nwn.bioware.com/downloads/linuxclient.html"
SRC_URI="http://nwdownloads.bioware.com/neverwinternights/linux/${MY_PV}/nwclient${MY_PV}.tar.gz
	linguas_fr? (
		http://files.bioware.com/neverwinternights/updates/linux/nwfrench${MY_PV}.tar.gz
		ftp://jeuxlinux.com/bioware/Neverwinter_Nights/nwfrench${MY_PV}.tar.gz )
	linguas_it? (
		http://nwdownloads.bioware.com/neverwinternights/linux/${MY_PV}/nwitalian${MY_PV}.tar.gz )
	linguas_es? (
		http://nwdownloads.bioware.com/neverwinternights/linux/${MY_PV}/nwspanish${MY_PV}.tar.gz )
	linguas_de? (
		http://files.bioware.com/neverwinternights/updates/linux/nwgerman${MY_PV}.tar.gz
		http://xfer06.fileplanet.com/%5E389272944/082003/nwgerman${MY_PV}.tar.gz )
	nowin? (
		http://files.bioware.com/neverwinternights/updates/linux/nwresources${MY_PV}.tar.gz
		http://bsd.mikulas.com/nwresources${MY_PV}.tar.gz
		http://163.22.12.40/FreeBSD/distfiles/nwresources${MY_PV}.tar.gz
		ftp://jeuxlinux.com/bioware/Neverwinter_Nights/nwresources${MY_PV}.tar.gz )
	mirror://gentoo/nwn.png
	http://dev.gentoo.org/~wolf31o2/sources/dump/nwn.png"

LICENSE="NWN-EULA"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nowin sou hou"
RESTRICT="strip mirror"

RDEPEND="virtual/opengl
	>=media-libs/libsdl-1.2.5
	amd64? (
		app-emulation/emul-linux-x86-baselibs )"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/nwn

GAMES_LICENSE_CHECK=yes
dir=${GAMES_PREFIX_OPT}/nwn
Ddir=${D}/${dir}

pkg_setup() {
	games_pkg_setup
	if use sou && use hou
	then
		echo "You will need the SoU and HoU CDs for this installation."
		cdrom_get_cds NWNSoUInstallGuide.rtf \
			ArcadeInstallNWNXP213f.EXE
	elif use sou
	then
		 echo "You will need the SoU CD for this installation."
		cdrom_get_cds NWNSoUInstallGuide.rtf
	elif use hou
	then
		 echo "You will need the HoU CD for this installation."
		cdrom_get_cds ArcadeInstallNWNXP213f.EXE
	fi
}

src_unpack() {
	mkdir "${S}"
	cd "${S}"
	# We create this .metadata directory so we can keep track of what we have
	# installed without needing to keep all of these multiple USE flags in all
	# of the ebuilds.
	mkdir -p "${S}"/.metadata || die "Creating .metadata"
	if use linguas_de
	then
		touch .metadata/linguas_de || die "touching de"
	elif use linguas_es
	then
		touch .metadata/linguas_es || die "touching es"
	elif use linguas_fr
	then
		touch .metadata/linguas_fr || die "touching fr"
	elif use linguas_it
	then
		touch .metadata/linguas_it || die "touching it"
	else
		touch .metadata/linguas_en || die "touching en"
	fi
	unpack nwclient${MY_PV}.tar.gz
	if use nowin
	then
		cd "${WORKDIR}"
		unpack nwresources${MY_PV}.tar.gz || die "unpacking nwresources${MY_PV}.tar.gz"
		cd "${S}"
	fi
	rm -rf override/*
	# the following is so ugly, please pretend it doesnt exist
	declare -a Aarray=(${A})
	use nowin && if [ "${#Aarray[*]}" == "4" ]
	then
		unpack ${Aarray[1]}
	fi
	if use sou
	then
		unzip -o "${CDROM_ROOT}"/Data_Shared.zip || die "unpacking"
		unzip -o "${CDROM_ROOT}"/Language_data.zip || die "unpacking"
		unzip -o "${CDROM_ROOT}"/Language_update.zip || die "unpacking"
		unzip -o "${CDROM_ROOT}"/Data_Linux.zip || die "unpacking"
		touch .metadata/sou || die "touching sou"
	fi
	if use hou
	then
		if use sou && use hou
		then
			rm -f xp1patch.key data/xp1patch.bif override/*
			cdrom_load_next_cd
		fi
		unzip -o "${CDROM_ROOT}"/Data_Shared.zip || die "unpacking"
		unzip -o "${CDROM_ROOT}"/Language_data.zip || die "unpacking"
		unzip -o "${CDROM_ROOT}"/Language_update.zip || die "unpacking"
		touch .metadata/hou || die "touching hou"
	fi
	# These files aren't needed and come from the patches (games-rpg/nwn)
	rm -f data/patch.bif patch.key

	sed -i -e '\:^./nwmain .*:i \
if [[ -f ./nwmouse.so ]]; then \
	export XCURSOR_PATH="$(pwd)" \
	export XCURSOR_THEME=nwmouse \
	export LD_PRELOAD=./nwmouse.so:$LD_PRELOAD \
fi \
	' "${S}/nwn" || die "sed nwn"
}

src_install() {
	dodir "${dir}"
	# Since the movies don't play anyway, we'll remove them.  This should
	# eventually be removed to allow for nwmovies to work.
	rm -rf "${S}"/movies
	mkdir -p "${S}"/dmvault "${S}"/hak "${S}"/portraits "${S}"/localvault
	rm -rf "${S}"/dialog.tlk "${S}"/dialog.TLK "${S}"/dialogf.tlk \
		"${S}"/dmclient "${S}"/nwmain "${S}"/nwserver  "${S}"/nwm/* \
		"${S}"/SDL-1.2.5 "${S}"/fixinstall
	mv "${S}"/* "${Ddir}"
	mv "${S}"/.metadata "${Ddir}"
	keepdir "${dir}"/servervault
	keepdir "${dir}"/scripttemplates
	keepdir "${dir}"/saves
	keepdir "${dir}"/portraits
	keepdir "${dir}"/hak
	cd "${Ddir}"
	for d in ambient data dmvault hak localvault music override portraits
	do
		if [ -d ${d} ]
		then
			cd ${d}
			for f in $(find . -name '*.*') ; do
				lcf=$(echo ${f} | tr [:upper:] [:lower:])
				if [ ${f} != ${lcf} ] && [ -f ${f} ]
				then
					mv ${f} $(echo ${f} | tr [:upper:] [:lower:])
				fi
			done
			cd "${Ddir}"
		fi
	done
	if ! use sou && ! use hou && use nowin
	then
		chmod a-x ${Ddir}/data/patch.bif ${Ddir}/patch.key
	fi
	doicon "${DISTDIR}"/nwn.png

	prepgamesdirs
	chmod -R g+rwX ${Ddir}/saves ${Ddir}/localvault ${Ddir}/dmvault \
		2>&1 > /dev/null || die "could not chmod"
	chmod g+rwX ${Ddir} || die "could not chmod"
}

pkg_postinst() {
	games_pkg_postinst
	if ! use nowin ; then
		einfo "The NWN linux client data is now installed."
		einfo "Proceed with the following steps in order to get it working:"
		einfo "1) Copy the following directories/files from your installed and"
		einfo "   patched (1.66) Neverwinter Nights to ${dir}:"
		einfo "    ambient/"
		einfo "    data/"
		einfo "    dmvault/"
		einfo "    hak/"
		einfo "    localvault/"
		einfo "    modules/"
		einfo "    music/"
		einfo "    portraits/"
		einfo "    saves/"
		einfo "    servervault/"
		einfo "    texturepacks/"
		einfo "    chitin.key"
		einfo "2) Remove some files to make way for the patch"
		einfo "    rm ${dir}/music/mus_dd_{kingmaker,shadowgua,witchwake}.bmu"
		einfo "    rm ${dir}/override/iit_medkit_001.tga"
		einfo "    rm ${dir}/data/patch.bif"
		if use sou
		then
			einfo "    rm ${dir}/xp1patch.key ${dir}/data/xp1patch.bif"
		fi
		if use hou
		then
			einfo "    rm ${dir}/xp2patch.key ${dir}/data/xp2patch.bif"
		fi
		einfo "3) Chown and chmod the files with the following commands"
		einfo "    chown -R ${GAMES_USER}:${GAMES_GROUP} ${dir}"
		einfo "    chmod -R g+rwX ${dir}"
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
