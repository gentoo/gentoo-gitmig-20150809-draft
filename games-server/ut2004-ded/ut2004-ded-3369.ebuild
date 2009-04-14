# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/ut2004-ded/ut2004-ded-3369.ebuild,v 1.12 2009/04/14 07:30:35 mr_bones_ Exp $

inherit games

DESCRIPTION="Unreal Tournament 2004 Linux Dedicated Server"
HOMEPAGE="http://www.unrealtournament.com/"

MY_P="dedicatedserver3339-bonuspack.zip"
MY_P2="ut2004-lnxpatch${PV}-2.tar.bz2"
SRC_URI="mirror://3dgamers/unrealtourn2k4/${MY_P}
	http://downloads.unrealadmin.org/UT2004/Patches/Linux/${MY_P}
	http://sonic-lux.net/data/mirror/ut2004/${MY_P}
	mirror://3dgamers/unrealtourn2k4/${MY_P2}
	http://downloads.unrealadmin.org/UT2004/Server/${MY_P2}
	http://sonic-lux.net/data/mirror/ut2004/${MY_P2}"

LICENSE="ut2003"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror strip"
PROPERTIES="interactive"

DEPEND="app-arch/unzip"
RDEPEND="=virtual/libstdc++-3.3"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

src_install() {
	einfo "This will take a while ... go get a pizza or something"

	dodir ${dir}
	cp -r ${S}/UT2004-Patch/* ${S}
	rm -rf ${S}/UT2004-Patch
	cp -r ${S}/* ${Ddir}

	if use amd64 ; then
		rm ${Ddir}/System/ucc-bi{n,n-macosx} \
			|| die "removing unused binaries"
		mv ${Ddir}/System/ucc-bin-linux-amd64 ${Ddir}/System/ucc-bin \
			|| die "renaming ucc-bin-amd64 => ucc-bin"
	else
		rm ${Ddir}/System/ucc-bin-{linux-amd64,macosx} \
			|| die "removing unused binaries"
	fi

	fperms 0770 ${dir}/System/ucc-bin || die "fixing permissions on ucc-bin"
	rm -f ${Ddir}/System/*.dll || die "removing windows dlls"
	rm -f ${Ddir}/System/*.exe || die "removing windows exes"

	newinitd ${FILESDIR}/ut2004-ded.rc ut2004-ded
	dosed "s:GAMES_PREFIX_OPT:${GAMES_PREFIX_OPT}:" \
		/etc/init.d/ut2004-ded || die "sed"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "The server can be started with the /etc/init.d/ut2004-ded init script."
	echo
	ewarn "You should take the time to edit the default server INI."
	ewarn "Consult the INI Reference at http://unrealadmin.org/"
	ewarn "for assistance in adjusting the following file:"
	ewarn "  ${GAMES_PREFIX_OPT}/ut2004-ded/System/Default.ini"
	echo
	ewarn "NOTE: To have your server authenticate properly to the"
	ewarn "      central server, you MUST visit the following site"
	ewarn "      and request a key. This is not required if you"
	ewarn "      want an unfindable private server. [DoUplink=False]"
	echo
	ewarn "      http://unreal.epicgames.com/ut2004server/cdkey.php"
	echo
}
