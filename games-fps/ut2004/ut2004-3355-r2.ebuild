# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004/ut2004-3355-r2.ebuild,v 1.2 2005/08/03 16:49:26 wolf31o2 Exp $

inherit eutils games

MY_P="${PN}-lnxpatch${PV}.tar.bz2"
DESCRIPTION="Unreal Tournament 2004 - Editor's Choice Edition"
HOMEPAGE="http://www.unrealtournament2004.com/"
SRC_URI="mirror://3dgamers/pub/3dgamers/games/unrealtourn2k4/${MY_P}
	http://speculum.twistedgamer.com/pub/0day.icculus.org/${PN}/${MY_P}
	experimental? ( http://icculus.org/~icculus/tmp/${PN}-lnx-${PV}-with-rendertargets.tar.bz2 )"

LICENSE="ut2003"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="nostrip nomirror"
IUSE="opengl dedicated experimental"

RDEPEND="games-fps/ut2004-data
	games-fps/ut2004-bonuspack-ece
	opengl? ( virtual/opengl )
	dedicated? ( app-misc/screen )"

S=${WORKDIR}/UT2004-Patch

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	check_license || die "License check failed"
	if use experimental
	then
		ewarn "You are enabling support for an experimental patch from icculus."
		ewarn "This patch solves some missing issues with the Linux version of"
		ewarn "the game.  Please report all bugs you find with this version to"
		ewarn "https://bugzilla.icculus.org"
		ebeep
		epause
	fi
	games_pkg_setup
}

src_install() {
	# moving patched binary into proper location
	 use experimental && mv -f ${WORKDIR}/ut2004-bin ${S}/System

	# Installing patch files
	for p in {Animations,Help,Speech,System,Textures,Web}
	do
		dodir ${dir}/${p}
		cp -r ${S}/${p}/* ${Ddir}/${p} \
			|| die "copying ${p} from patch"
	done

	use amd64 && rm ${Ddir}/System/u{cc,t2004}-bin \
		&& mv ${Ddir}/System/ucc-bin-linux-amd64 ${Ddir}/System/ucc-bin \
		&& mv ${Ddir}/System/ut2004-bin-linux-amd64 ${Ddir}/System/ut2004-bin \
		&& chmod ug+x ${Ddir}/System/ucc-bin ${Ddir}/System/ut2004-bin
	use x86 && rm ${Ddir}/System/ucc-bin-linux-amd64 \
		${Ddir}/System/ut2004-bin-linux-amd64

	# creating .manifest files
	insinto ${dir}/.manifest
	doins ${FILESDIR}/${PN}.xml

	# creating .loki/installed links
	mkdir -p ${D}/root/.loki/installed
	dosym ${dir}/.manifest/${PN}.xml ${ROOT}/root/.loki/installed/${PN}.xml

	# Here we edit the Default.ini to enable support for the experimentla patch
#	if use experimental
#	then
#		ed ${Ddir}/System/Default.ini >/dev/null 2>&1 <<EOT
#$
#?OpenGLDrv.OpenGLRenderDevice?
#a
#UseRenderTargets=True
#.
#w
#q
#EOT
#		sed -i -e 's/bPlayerShadows=False/bPlayerShadows=True/' \
#			-e 's/bBlobShadow=True/bBlobShadow=False/' \
#			-e 's/bVehicleShadows=False/bVehicleShadows=True/' \
#			${Ddir}/System/DefUser.ini
#	fi

	games_make_wrapper ut2004 ./ut2004 ${dir}

	prepgamesdirs
	make_desktop_entry ut2004 "Unreal Tournament 2004" ut2004.xpm
}

pkg_postinst() {
	games_pkg_postinst

	# here is where we check for the existence of a cdkey...
	# if we don't find one, we ask the user for it
	if [ -f ${dir}/System/cdkey ]; then
		einfo "A cdkey file is already present in ${dir}/System"
	else
		ewarn "You MUST run this before playing the game:"
		ewarn "ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
		ewarn "That way you can [re]enter your cdkey."
	fi
	echo
	einfo "To play the game run:"
	einfo " ut2004"
	echo
	if use experimental
	then
		ewarn "If you are not installing for the first time and wish to test"
		ewarn "the new Render to Texture patch, then you will probably need to"
		ewarn "edit your ~/.ut2004/System/UT2004.ini file and add a line that"
		ewarn "says UseRenderTargets=True to your"
		ewarn "[OpenGLDrv.OpenGLRenderDevice] section.  You will also need to"
		ewarn "edit your ~/.ut2004/System/User.ini file and make sure that you"
		ewarn "have bPlayerShadows=True and bBlobShadow=False in your"
		ewarn "[UnrealGame.UnrealPawn] section.  Also, be sure to set"
		ewarn "bVehicleShadows=True in your [Engine.Vehicle] section."
		ebeep
		epause
	fi
}

pkg_postrm() {
	ewarn "This package leaves a cdkey file in ${dir}/System that you need"
	ewarn "to remove to completely get rid of this game's files."
}

pkg_config() {
	ewarn "Your CD key is NOT checked for validity here."
	ewarn "  Make sure you type it in correctly."
	eerror "If you CTRL+C out of this, the game will not run!"
	echo
	einfo "CD key format is: XXXXX-XXXXX-XXXXX-XXXXX"
	while true ; do
		einfo "Please enter your CD key:"
		read CDKEY1
		einfo "Please re-enter your CD key:"
		read CDKEY2
		if [ "$CDKEY1" == "" ] ; then
			echo "You entered a blank CD key.  Try again."
		else
			if [ "$CDKEY1" == "$CDKEY2" ] ; then
				echo "$CDKEY1" | tr a-z A-Z > ${dir}/System/cdkey
				einfo "Thank you!"
				break
			else
				eerror "Your CD key entries do not match.  Try again."
			fi
		fi
	done
}
