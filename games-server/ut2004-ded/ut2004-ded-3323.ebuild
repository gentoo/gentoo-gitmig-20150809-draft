# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/ut2004-ded/ut2004-ded-3323.ebuild,v 1.1 2004/09/14 21:49:41 wolf31o2 Exp $

inherit games

DESCRIPTION="Unreal Tournament 2004 Linux Dedicated Server"
HOMEPAGE="http://www.unrealtournament.com/"

ORIG_P="ut2004-3186-dedicatedserver.zip"
PATCH_P="ut2004-lnxpatch${PV}.tar.bz2"
SRC_URI="mirror://3dgamers/pub/3dgamers5/games/unrealtourn2k4/${ORIG_P}
	mirror://3dgamers/pub/3dgamers/games/unrealtourn2k4/${ORIG_P}
	mirror://3dgamers/pub/3dgamers5/games/unrealtourn2k4/${PATCH_P}
	mirror://3dgamers/pub/3dgamers/games/unrealtourn2k4/${PATCH_P}"

LICENSE="ut2003"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="nostrip nomirror"

DEPEND="app-arch/unzip"

S=${WORKDIR}
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	check_license || die "License check failed"
	games_pkg_setup
}

src_unpack() {
	unzip ${DISTDIR}/${ORIG_P}
	unpack ${PATCH_P}
}

src_install() {
	einfo "This will take a while ... go get a pizza or something"

	dodir ${dir}
	rm -f ${D}/ut2004-bi{n,n-linux-amd64} || die "Removing ut2004 binaries"
	cp -r ${S}/UT2004-Patch/* ${S} || die "Patching server to current..."
	rm -rf ${S}/UT2004-Patch
	cp -r ${S}/* ${Ddir}

	if use amd64 ; then
		rm ${Ddir}/System/{ucc-bi{n,n-macosx},UCC.exe} \
			|| die "removing unused binaries"
		mv ${Ddir}/System/ucc-bin-linux-amd64 ${Ddir}/System/ucc-bin \
			|| die "renaming ucc-bin-amd64 => ucc-bin"
	else
		rm ${Ddir}/System/{ucc-bin-{linux-amd64,macosx},UCC.exe} \
			|| die "removing unused binaries"
	fi

	fperms 0770 ${dir}/System/ucc-bin || die "fixing permissions on ucc-bin"
	rm -f ${Ddir}/System/*.dll || die "removing windows dlls"

	prepgamesdirs

	exeinto /etc/init.d
	newexe ${FILESDIR}/ut2004-ded.rc ut2004-ded
}

pkg_postinst() {
	echo
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
	games_pkg_postinst
}
