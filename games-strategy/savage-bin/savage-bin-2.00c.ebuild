# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/savage-bin/savage-bin-2.00c.ebuild,v 1.1 2006/10/05 20:41:09 wolf31o2 Exp $

inherit eutils games

SEP_URI="http://www.notforidiots.com/autoupdater/"
BASE_URI="http://downloads.s2games.com/online_orders/"

DESCRIPTION="Unique mix of strategy and FPS"
HOMEPAGE="http://savage.s2games.com/"
SRC_URI="${BASE_URI}/savage_linux.sh.gz
		mirror://liflg/savage_${PV}-english.update.run
		${SEP_URI}/SEP-3T.tar.gz
		${SEP_URI}/SEP-3T_3T+-r2.tar.gz
		x86? ( !sse? ( ${SEP_URI}/SEP-2C-noSSE.tar.gz ) )"
#		doc? (${MANUAL_URI})"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="sse doc"
RESTRICT="mirror strip"
DEPEND="games-util/loki_patch"

RDEPEND=""

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/savage
Ddir=${D}/${dir}

src_unpack() {
	einfo "Unpacking base file"
	einfo "This will take a while"
	unpack savage_linux.sh.gz
	unpack_makeself ${S}/savage_linux.sh || die "unpacking base files"
	find ./ -type f -name '*.dll' -exec rm '{}' \;
	find ./ -type f -name '*.exe' -exec rm '{}' \;
	find ./ -type f -name '*.bat' -exec rm '{}' \;
	rm Savage/docs/*.url
	rm savage_linux.sh
	einfo "Unpacking other files"
	mkdir patch
	cd patch
	unpack_makeself savage_${PV}-english.update.run
	cd ..
	mkdir sep
	cd sep
	unpack SEP-3T.tar.gz
	unpack SEP-3T_3T+-r2.tar.gz
	if ! use sse && use x86 ; then
		unpack SEP-2C-noSSE.tar.gz
	fi
#	cd ..
#	if use doc;then
#		unpack ${MANUAL_URI}
#	fi
}

src_install() {
	dodir ${dir}
	insinto ${dir}
	doins -r Savage/*
	doins -r linux/*
	doins bin/x86/*
	cd patch
	loki_patch patch.dat ${Ddir} || die "patching failed"
	cd ..
	doins -r sep/*
#	if use doc; then
#		insinto ${dir}/docs
#		doins *.pdf
#	fi

	touch ${Ddir}/scripts.log

	prepgamesdirs

	fperms ug+x ${dir}/silverback.bin
	fperms ug+w ${dir}/scripts.log

	rm -rf ${Ddir}/savage* ${Ddir}/update ${Ddir}/updater \
		${Ddir}/editor.* ${Ddir}/dedicated* ${Ddir}/*.sh

	newicon linux/icon.xpm savage.xpm
	games_make_wrapper savage "./silverback.bin set mod game" ${dir} ${dir}/libs
	make_desktop_entry savage "Savage: Battle For Newerth" savage.xpm

	games_make_wrapper savage-editor "./silverback.bin set mod editor" ${dir} ${dir}/libs
	make_desktop_entry savage-editor "Savage - Editor" savage.xpm

	games_make_wrapper savage-graveyard "./silverback.bin set mod graveyard" ${dir} ${dir}/libs
	make_desktop_entry savage-graveyard "Savage - Graveyard" savage.xpm

}

pkg_postinst() {
	games_pkg_postinst
	einfo " USE CDKEY:00000000000000000000 to activate game"
}
