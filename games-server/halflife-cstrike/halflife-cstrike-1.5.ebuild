# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/halflife-cstrike/halflife-cstrike-1.5.ebuild,v 1.3 2004/02/20 07:31:48 mr_bones_ Exp $

inherit games

DESCRIPTION="Halflife Counterstrike mod (server only, client only works in wine)"
HOMEPAGE="http://www.counter-strike.net/"
SRC_URI="ftp://ftp.splatterworld.de/games/hl/mods/cs/server/cs_${PV//.}_full.tar.gz"

SLOT="0"
LICENSE="ValveServer"
KEYWORDS="-* x86"
IUSE="dedicated"
RESTRICT="nostrip"

RDEPEND="games-server/halflife-server
	dedicated? ( app-misc/screen )"

S=${WORKDIR}/cstrike

src_install() {
	local dir=${GAMES_PREFIX_OPT}/halflife
	dodir ${dir}

	mv server.cfg server.cfg.default
	cp ${FILESDIR}/server.cfg server.cfg
	mv ${S} ${D}/${dir}/ || die "moving cstrike"

	dogamesbin ${FILESDIR}/hlds-cstrike
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/hlds-cstrike

	exeinto /etc/init.d ; newexe ${FILESDIR}/hlds-cstrike.rc hlds-cstrike
	dosed "s:GENTOO_DIR:${GAMES_BINDIR}:" /etc/init.d/hlds-cstrike
	dosed "s:GENTOO_GAMES_USER:${GAMES_USER_DED}:" /etc/init.d/hlds-cstrike
	insinto /etc/conf.d ; newins ${FILESDIR}/hlds-cstrike.conf.d hlds-cstrike
	dosed "s:GENTOO_DIR:${dir}:" /etc/conf.d/hlds-cstrike

	local cdir=${GAMES_SYSCONFDIR}/halflife/cstrike
	dodir ${cdir}
	# this allows users to upgrade w/out losing their previous settings
	dir=${dir}/cstrike
	for cfg in server.cfg liblist.gam mapcycle.txt motd.txt ; do
		[ -e ${dir}/${cfg} ] && mv ${D}/${dir}/${cfg}{,.sample}
		dosym {${dir},${cdir}}/${cfg}
	done

	prepgamesdirs
}

pkg_postinst() {
	local dir=${GAMES_PREFIX_OPT}/halflife/cstrike
	touch ${dir}/{server.cfg,liblist.gam,mapcycle.txt,motd.txt}

	einfo "To start the dedicated server, just run"
	einfo "/etc/init.d/hlds-cstrike start"
	echo
	einfo "The server utilizes screen so you can get to"
	einfo "the console by typing:"
	einfo " screen -r hlds-cstrike"
	echo
	einfo "To configure your server, just edit the file:"
	einfo "${GAMES_PREFIX_OPT}/halflife/cstrike/server.cfg"
	einfo "For an example config file, use"
	einfo "/opt/halflife/cstrike/server.cfg.sample"

	games_pkg_postinst
}
