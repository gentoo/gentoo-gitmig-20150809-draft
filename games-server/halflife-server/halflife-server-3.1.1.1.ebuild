# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/halflife-server/halflife-server-3.1.1.1.ebuild,v 1.1 2003/09/10 05:51:11 vapier Exp $

inherit games

MY_PN=hlds_l_3111_full
DESCRIPTION="Halflife Linux Server"
SRC_URI="${MY_PN}.bin"
HOMEPAGE="http://www.valve.com/ http://www.fileplanet.com/files/50000/58368.shtml"

LICENSE="ValveServer"
SLOT="0"
KEYWORDS="-* ~x86"
RESTRICT="nostrip fetch"

DEPEND="sys-apps/util-linux"
RDEPEND="dedicated? ( app-misc/screen )"

S=${WORKDIR}/hlds_l

pkg_nofetch() {
	einfo "Please goto fileplanet and d/l ${MY_BIN}"
	einfo "http://www.fileplanet.com/files/50000/58368.shtml"
}

src_unpack() {
	local metastart=`tail -c 8 ${DISTDIR}/${MY_PN}.bin | head -c 4 | hexdump -e \"%i\"`
	local newsize=$(expr $(ls -al ${DISTDIR}/${MY_PN}.bin | awk '{print $5}') - $metastart)
	tail -c ${newsize} ${DISTDIR}/${MY_PN}.bin > ${MY_PN}.bin
	tar -xf ${MY_PN}.bin
	echo ">>> Unpacking ${MY_PN}.tar.gz to ${S}"
	tar -zxf ${MY_PN}.tar.gz
	unpack hlds_l_3111d_update.tar.gz
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

	einfo "To start the dedicated server, just run"
	einfo "/etc/init.d/hlds start"
	echo
	einfo "The server utilizes screen so you can get to"
	einfo "the console by typing:"
	einfo " screen -r hlds"
	echo
	einfo "To configure your server, just edit the file:"
	einfo "${GAMES_PREFIX_OPT}/halflife/valve/server.cfg"

	games_pkg_postinst
}
