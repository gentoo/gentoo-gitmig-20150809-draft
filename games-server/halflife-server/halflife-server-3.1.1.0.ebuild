# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/halflife-server/halflife-server-3.1.1.0.ebuild,v 1.6 2004/02/20 07:31:48 mr_bones_ Exp $

inherit games eutils

MY_PV=${PV//.}
MY_PN=hlds_l_${MY_PV}_full
DESCRIPTION="Halflife Linux Server"
HOMEPAGE="http://www.valve.com/"
SRC_URI="${MY_PN}.bin boffix_v3.tar.gz"

LICENSE="ValveServer"
SLOT="0"
KEYWORDS="x86"
RESTRICT="nostrip fetch"

DEPEND="sys-apps/util-linux"
RDEPEND="app-misc/screen"

S=${WORKDIR}/hlds_l

pkg_nofetch() {
	einfo "Please goto fileplanet and d/l ${MY_BIN}"
	einfo "http://www.fileplanet.com/files/50000/58368.shtml"
	einfo "Then download boffix_v3.tar.gz from here:"
	einfo "http://miklos.clanhost.dk/boffix_v3.tar.gz"
}

src_unpack() {
	unpack_pdv ${MY_PN}.bin 4
	echo ">>> Unpacking ${MY_PN}.tar.gz to ${S}"
	tar -zxf ${MY_PN}.tar.gz
	rm ${MY_PN}.tar.gz
	cd ${S}
	unpack boffix_v3.tar.gz
	epatch ${FILESDIR}/${PV}-hlds_run-boffix.patch
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/halflife
	dodir ${dir}

	mv ${S}/* ${D}/${dir}/ || die
	dodir ${dir}/valve/logs

	dogamesbin ${FILESDIR}/hlds
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/hlds

	exeinto /etc/init.d ; newexe ${FILESDIR}/hlds.rc hlds
	dosed "s:GENTOO_DIR:${GAMES_BINDIR}:" /etc/init.d/hlds
	dosed "s:GENTOO_GAMES_USER:${GAMES_USER_DED}:" /etc/init.d/hlds
	insinto /etc/conf.d ; newins ${FILESDIR}/hlds.conf.d hlds
	dosed "s:GENTOO_DIR:${dir}:" /etc/conf.d/hlds

	local cdir=${GAMES_SYSCONFDIR}/halflife
	dodir ${cdir}
	# this allows users to upgrade w/out losing their previous settings
	[ -e ${dir}/hltv.cfg ] && mv ${D}/${dir}/hltv.cfg{,.sample}
	dosym {${dir},${cdir}}/hltv.cfg
	for mod in tfc valve dmc ricochet ; do
		dodir ${cdir}/${mod}
		for cfg in server.cfg liblist.gam mapcycle.txt motd.txt ; do
			[ -e ${dir}/${mod}/${cfg} ] && [ -e ${D}/${dir}/${mod}/${cfg} ] && \
				mv ${D}/${dir}/${mod}/${cfg}{,.sample}
			dosym {${dir},${cdir}}/${mod}/${cfg}
		done
	done

	prepgamesdirs
}

pkg_postinst() {
	local dir=${GAMES_PREFIX_OPT}/halflife
	touch ${dir}/hltv.cfg
	touch ${dir}/{dmc,ricochet,tfc,valve}/{server.cfg,liblist.gam,mapcycle.txt,motd.txt}

	games_pkg_postinst

	einfo "To start the dedicated server, just run"
	einfo "/etc/init.d/hlds start"
	echo
	einfo "The server utilizes screen so you can get to"
	einfo "the console by typing:"
	einfo " screen -r hlds"
	echo
	einfo "To configure your server, just edit the file:"
	einfo "${GAMES_PREFIX_OPT}/halflife/valve/server.cfg"
}
