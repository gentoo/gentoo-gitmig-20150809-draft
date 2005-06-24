# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004/ut2004-3355-r1.ebuild,v 1.2 2005/06/24 13:27:38 wolf31o2 Exp $

inherit games

MY_P="${PN}-lnxpatch${PV}.tar.bz2"
DESCRIPTION="Unreal Tournament 2004 - Editor's Choice Edition"
HOMEPAGE="http://www.unrealtournament2004.com/"
SRC_URI="mirror://3dgamers/pub/3dgamers/games/unrealtourn2k4/${MY_P}
	http://speculum.twistedgamer.com/pub/0day.icculus.org/${PN}/${MY_P}
	http://icculus.org/~icculus/tmp/${PN}-lnx-amd64-05282005.tar.bz2"

LICENSE="ut2003"
SLOT="0"
KEYWORDS="amd64"
RESTRICT="nostrip nomirror"
IUSE="opengl dedicated"

RDEPEND="games-fps/ut2004-data
	games-fps/ut2004-bonuspack-ece
	opengl? ( virtual/opengl )
	dedicated? ( app-misc/screen )"

S=${WORKDIR}/UT2004-Patch

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	check_license || die "License check failed"

	games_pkg_setup
}

src_install() {
	# moving patched binary into proper location
	mv -f ${WORKDIR}/ut2004-bin-linux-amd64 ${S}/System

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
