# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/halflife-statsme/halflife-statsme-2.7.1.ebuild,v 1.3 2004/02/20 07:31:48 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="plugin for metamod to track in game statistics in real time"
HOMEPAGE="http://www.unitedadmins.com/statsme.php"
SRC_URI="!nocstrike? ( mirror://sourceforge/statsme/statsme-${PV}-cstrike.zip )
	!nocstrike? ( mirror://sourceforge/statsme/statsme-${PV}-cstrike-scriptpacks.zip )
	!nodod? ( mirror://sourceforge/statsme/statsme-${PV}-dod.zip )
	!nodod? ( mirror://sourceforge/statsme/statsme-${PV}-dod-scriptpacks.zip )
	!notfc? ( mirror://sourceforge/statsme/statsme-${PV}-tfc.zip )
	!notfc? ( mirror://sourceforge/statsme/statsme-${PV}-tfc-scriptpacks.zip )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE="nocstrike nodod notfc"

RDEPEND="games-server/halflife-metamod"

S=${WORKDIR}

src_unpack() {
	for m in cstrike dod tfc ; do
		[ `use no${m}` ] && continue
		mkdir ${S}/${m}
		cd ${S}/${m}
		unpack statsme-${PV}-${m}.zip
		cd addons/statsme/scriptpacks
		unpack statsme-${PV}-${m}-scriptpacks.zip
		cd ..
		edos2unix `find -name '*.txt' -o -name '*.cfg' -o -name 'README.*'`
		epatch ${FILESDIR}/${PV}-${m}-gentoo.patch
	done
	cd ${S}
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/halflife/addons/statsme
	for m in cstrike dod tfc ; do
		[ `use no${m}` ] && continue
		dodir ${dir}-${m}
		cd ${S}/${m}/addons/statsme
		#sed -i "s:addons/statsme/:../addons/statsme-${m}/:g" \
		#	statsme.cfg scriptpacks.cfg scriptpacks/*/README.*
		mv * ${D}/${dir}-${m}/
		exeinto ${dir}-${m}
		doexe ${FILESDIR}/modsetup
		dosed "s:GENTOO_CFGDIR:${GAMES_SYSCONFDIR}/halflife:" ${dir}-${m}/modsetup
		dosed "s:HLMODDIR:${m}:" ${dir}-${m}/modsetup
	done
	dodoc ${WORKDIR}/*/*.txt
	prepgamesdirs
}
