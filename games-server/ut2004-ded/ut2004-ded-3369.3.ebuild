# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/ut2004-ded/ut2004-ded-3369.3.ebuild,v 1.1 2009/09/03 12:37:38 nyhm Exp $

inherit games

BONUSPACK_P="dedicatedserver3339-bonuspack.zip"
PATCH_P="ut2004-lnxpatch${PV%.*}-2.tar.bz2"
DESCRIPTION="Unreal Tournament 2004 Linux Dedicated Server"
HOMEPAGE="http://www.unrealtournament.com/"
SRC_URI="mirror://3dgamers/unrealtourn2k4/${BONUSPACK_P}
	http://downloads.unrealadmin.org/UT2004/Patches/Linux/${BONUSPACK_P}
	http://sonic-lux.net/data/mirror/ut2004/${BONUSPACK_P}
	mirror://3dgamers/unrealtourn2k4/${PATCH_P}
	http://downloads.unrealadmin.org/UT2004/Server/${PATCH_P}
	http://sonic-lux.net/data/mirror/ut2004/${PATCH_P}
	mirror://gentoo/ut2004-v${PV/./-}-linux-dedicated.7z"

LICENSE="ut2003"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"
PROPERTIES="interactive"

DEPEND="app-arch/unzip
	app-arch/p7zip"
RDEPEND="sys-libs/glibc"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}

src_unpack() {
	unpack ${A}
	cp -rf UT2004-Patch/* . || die
	rm -rf System/{ucc-bin*,ut2004-bin*,*.dll,*.exe} UT2004-Patch
	if use amd64 ; then
		mv -f ut2004-ucc-bin-09192008/ucc-bin-linux-amd64 System/ucc-bin || die
	else
		mv -f ut2004-ucc-bin-09192008/ucc-bin System/ || die
	fi
	rm -rf ut2004-ucc-bin-09192008
}

src_install() {
	einfo "This will take a while... go get a pizza or something"

	insinto "${dir}"
	doins -r * || die "doins failed"
	fperms +x "${dir}"/System/ucc-bin || die "fperms failed"

	sed \
		-e "s:@USER@:${GAMES_USER_DED}:" \
		-e "s:@GROUP@:${GAMES_GROUP}:" \
		"${FILESDIR}"/${PN}.confd > "${T}"/${PN}.confd \
		|| die "sed confd failed"
	newconfd "${T}"/${PN}.confd ${PN} || die "newconfd failed"

	sed \
		-e "s:@DIR@:${dir}/System:g" \
		"${FILESDIR}"/${PN}.initd > "${T}"/${PN}.initd \
		|| die "sed initd failed"
	newinitd "${T}"/${PN}.initd ${PN} || die "initd failed"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "The server can be started using the /etc/init.d/ut2004-ded script."
	ewarn "You should take the time to edit the default server INI."
	ewarn "Consult the INI Reference at http://unrealadmin.org/"
	ewarn "for assistance in adjusting the following file:"
	ewarn "${dir}/System/Default.ini"
	ewarn
	ewarn "To have your server authenticate properly to the"
	ewarn "central server, you MUST visit the following site"
	ewarn "and request a key. This is not required if you"
	ewarn "want an unfindable private server. [DoUplink=False]"
	ewarn
	ewarn "http://unreal.epicgames.com/ut2004server/cdkey.php"
}
