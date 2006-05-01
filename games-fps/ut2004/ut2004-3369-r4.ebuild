# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004/ut2004-3369-r4.ebuild,v 1.8 2006/05/01 21:26:11 wolf31o2 Exp $

inherit eutils multilib games

MY_P="${PN}-lnxpatch${PV}-2.tar.bz2"
DESCRIPTION="Unreal Tournament 2004 - Editor's Choice Edition plus Mega Pack"
HOMEPAGE="http://www.unrealtournament2004.com/"
SRC_URI="mirror://3dgamers/unrealtourn2k4/${MY_P}
	http://speculum.twistedgamer.com/pub/0day.icculus.org/${PN}/${MY_P}
	http://treefort.icculus.org/${PN}/${MY_P}
	http://sonic-lux.net/data/mirror/ut2004/${MY_P}"

LICENSE="ut2003"
SLOT="0"
KEYWORDS="amd64 x86"
# The executable pages are required.
QA_EXECSTACK_x86="opt/ut2004/System/ut2004-bin opt/ut2004/System/ucc-bin"
QA_EXECSTACK_amd64="opt/ut2004/System/ut2004-bin opt/ut2004/System/ucc-bin"
RESTRICT="mirror strip"
IUSE="opengl"

RDEPEND=">=games-fps/ut2004-data-3186-r2
	>=games-fps/ut2004-bonuspack-ece-1-r1
	>=games-fps/ut2004-bonuspack-mega-1-r1
	opengl? (
		virtual/opengl )
	=virtual/libstdc++-3.3
	|| (
		(
			x11-libs/libXext
			x11-libs/libX11
			x11-libs/libXau
			x11-libs/libXdmcp )
		virtual/x11 )"
	# If you wish to use your system libSDL/openal, then you will need to remove
	# the comments from the following two lines, along with the quotes above and
	# this comment text.
#	>=media-libs/libsdl-1.2
#	media-libs/openal"

S=${WORKDIR}/UT2004-Patch

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

src_install() {
	# These files are owned by ut2004-bonuspack-mega
	rm "${S}"/System/{Manifest.in{i,t},Packages.md5}

	# Installing patch files
	for p in {Animations,Help,Speech,System,Textures,Web}
	do
		dodir "${dir}/${p}"
		cp -r "${S}/${p}"/* "${Ddir}/${p}" \
			|| die "copying ${p} from patch"
	done

	# To use system libraries, rather than binaries from ut2004-data, you will
	# need to uncomment these three lines, as well as ensure that you have both
	# libsdl and openal installed.
#	dosym /usr/$(get_libdir)/libopenal.so "${dir}"/System/openal.so || die
#	dosym /usr/$(get_libdir)/libSDL-1.2.so.0 "${dir}"/System/libSDL-1.2.so.0 \
#		|| die

	use amd64 && rm "${Ddir}"/System/u{cc,t2004}-bin \
		&& mv "${Ddir}"/System/ucc-bin-linux-amd64 "${Ddir}"/System/ucc-bin \
		&& mv "${Ddir}"/System/ut2004-bin-linux-amd64 \
		"${Ddir}"/System/ut2004-bin \
		&& chmod ug+x "${Ddir}"/System/ucc-bin "${Ddir}"/System/ut2004-bin
	use x86 && rm "${Ddir}"/System/ucc-bin-linux-amd64 \
		"${Ddir}"/System/ut2004-bin-linux-amd64

	# Creating .manifest files
	insinto "${dir}"/.manifest
	doins "${FILESDIR}"/${PN}.xml

	# Creating .loki/installed links
	mkdir -p "${D}"/root/.loki/installed
	dosym "${dir}"/.manifest/${PN}.xml "${ROOT}"/root/.loki/installed/${PN}.xml

	games_make_wrapper ut2004 ./ut2004 "${dir}" "${dir}"

	prepgamesdirs
	make_desktop_entry ut2004 "Unreal Tournament 2004" ut2004.xpm
}

pkg_postinst() {
	games_pkg_postinst

	# Here is where we check for the existence of a cdkey...
	# If we don't find one, we ask the user for it
	if [[ -f "${dir}/System/cdkey" ]]
	then
		einfo "A cdkey file is already present in ${dir}/System"
	else
		ewarn "You MUST run this before playing the game:"
		ewarn "emerge --config =${CATEGORY}/${PF}"
		ewarn "That way you can [re]enter your cdkey."
	fi
	echo
	einfo "Starting with 3369, the game supports render-to-texture.  To enable"
	einfo "it, you will need the Nvidia drivers of at least version 7676 and"
	einfo "you should edit the following:"
	einfo 'Set "UseRenderTargets=True" in the "[OpenGLDrv.OpenGLRenderDevice]"'
	einfo 'section of your UT2004.ini/Default.ini and set "bPlayerShadows=True"'
	einfo 'and "bBlobShadow=False" in the "[UnrealGame.UnrealPawn]" section of'
	einfo 'your User.ini/DefUser.ini'
	echo
	if use x86
	then
		einfo "The 32-bit version of UT2004 uses Pixomatic, which means it"
		einfo "really does need an executable stack.  It is safe to ignore any"
		einfo "warnings from portage about this.  See:"
		einfo "http://bugs.gentoo.org/show_bug.cgi?id=114733"
		einfo "for more information."
	fi
	echo
	einfo "To play the game run:"
	einfo " ut2004"
	echo
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
	while true
	do
		einfo "Please enter your CD key:"
		read CDKEY1
		einfo "Please re-enter your CD key:"
		read CDKEY2
		if [[ "$CDKEY1" == "" ]]
		then
			echo "You entered a blank CD key.  Try again."
		else
			if [[ "$CDKEY1" == "$CDKEY2" ]]
			then
				echo "$CDKEY1" | tr a-z A-Z > "${dir}"/System/cdkey
				einfo "Thank you!"
				break
			else
				eerror "Your CD key entries do not match.  Try again."
			fi
		fi
	done
}
