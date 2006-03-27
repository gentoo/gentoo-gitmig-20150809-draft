# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/ut2004-ded/ut2004-ded-3355.ebuild,v 1.5 2006/03/27 13:43:59 wolf31o2 Exp $

inherit games

DESCRIPTION="Unreal Tournament 2004 Linux Dedicated Server"
HOMEPAGE="http://www.unrealtournament.com/"

MY_P="dedicatedserver3339-bonuspack.zip"
MY_P2="ut2004-lnxpatch${PV}.tar.bz2"
SRC_URI="mirror://3dgamers/unrealtourn2k4/${MY_P}
	mirror://3dgamers/unrealtourn2k4/${MY_P2}"

LICENSE="ut2003"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="nostrip nomirror"

DEPEND="app-arch/unzip"

S=${WORKDIR}
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	check_license ut2003
	games_pkg_setup
}

src_install() {
	einfo "This will take a while ... go get a pizza or something"

	dodir ${dir}
	cp -r ${S}/UT2004-Patch/* ${S}
	rm -rf ${S}/UT2004-Patch
	cp -r ${S}/* ${Ddir}

	if use amd64 ; then
		rm ${Ddir}/System/{ucc-bi{n,n-macosx}} \
			|| die "removing unused binaries"
		mv ${Ddir}/System/ucc-bin-linux-amd64 ${Ddir}/System/ucc-bin \
			|| die "renaming ucc-bin-amd64 => ucc-bin"
	else
		rm ${Ddir}/System/{ucc-bin-{linux-amd64,macosx}} \
			|| die "removing unused binaries"
	fi

	fperms 0770 ${dir}/System/ucc-bin || die "fixing permissions on ucc-bin"
	rm -f ${Ddir}/System/*.dll || die "removing windows dlls"
	rm -f ${Ddir}/System/*.exe || die "removing windows exes"

	prepgamesdirs

	exeinto /etc/init.d
	newexe ${FILESDIR}/ut2004-ded.rc ut2004-ded
}

pkg_postinst() {
	games_pkg_postinst
	einfo "The server can be started with the /etc/init.d/ut2004-ded init script."
	echo
	ewarn "You should take the time to edit the default server INI."
	ewarn "Consult the INI Reference at http://unrealadmin.org/"
	ewarn "for assistance in adjusting the following file:"
	ewarn "      /opt/ut2004-ded/System/Default.ini"
	echo
	ewarn "NOTE: To have your server authenticate properly to the"
	ewarn "      central server, you MUST visit the following site"
	ewarn "      and request a key. This is not required if you"
	ewarn "      want an unfindable private server. [DoUplink=False]"
	echo
	ewarn "      http://unreal.epicgames.com/ut2004server/cdkey.php"
	echo
}
