# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/halflife-dpb/halflife-dpb-2.1.ebuild,v 1.3 2004/02/20 07:31:48 mr_bones_ Exp $

inherit games

DESCRIPTION="Halflife Digital Paintball mod"
HOMEPAGE="http://www.digitalpaintball.net/"
SRC_URI="http://www.linuxatron.com/dpb/dpb_v20.tar.gz
	http://philes.gamedaemons.net/halflife/digitalpaintball/dpb_v20.tar.gz
	http://www.elitethinking.net/files/dpb/patches/server/dpb_v20.tar.gz
	http://philes.gamedaemons.net/halflife/digitalpaintball/dpb_v2021.tar.gz
	http://www.zero-temptation.com/dpb_v2021.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="-* x86"
IUSE="dedicated"
RESTRICT="nostrip"

RDEPEND="games-server/halflife-server
	dedicated? ( app-misc/screen )"

S=${WORKDIR}/dpb

src_install() {
	local dir=${GAMES_PREFIX_OPT}/halflife
	dodir ${dir}

	mv ${S} ${D}/${dir}/ || die "moving dpb"

	dogamesbin ${FILESDIR}/hlds-dpb
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/hlds-dpb

	exeinto /etc/init.d ; newexe ${FILESDIR}/hlds-dpb.rc hlds-dpb
	dosed "s:GENTOO_DIR:${GAMES_BINDIR}:" /etc/init.d/hlds-dpb
	dosed "s:GENTOO_GAMES_USER:${GAMES_USER_DED}:" /etc/init.d/hlds-dpb
	insinto /etc/conf.d ; newins ${FILESDIR}/hlds-dpb.conf.d hlds-dpb
	dosed "s:GENTOO_DIR:${dir}:" /etc/conf.d/hlds-dpb

	# now set the gamedll
	local gamedll_linux=""
	if has_version =sys-libs/glibc-2.2* ; then
		gamedll_linux="2.2"
	elif has_version =sys-devel/gcc-2* ; then
		gamedll_linux="2.3-libstdc++5"
	else
		gamedll_linux="2.3"
	fi
	dosed "/gamedll_linux/s:\".*\":\"dlls/pb-i686-glibc${gamedll_linux}.so\":" ${dir}/dpb/liblist.gam

	local cdir=${GAMES_SYSCONFDIR}/halflife/dpb
	dodir ${cdir}
	# this allows users to upgrade w/out losing their previous settings
	dir=${dir}/dpb
	for cfg in server.cfg liblist.gam mapcycle.txt motd.txt ; do
		[ -e ${dir}/${cfg} ] && mv ${D}/${dir}/${cfg}{,.sample}
		dosym {${dir},${cdir}}/${cfg}
	done

	prepgamesdirs
}

pkg_postinst() {
	local dir=${GAMES_PREFIX_OPT}/halflife/dpb
	touch ${dir}/{server.cfg,liblist.gam,mapcycle.txt,motd.txt}

	einfo "To start the dedicated server, just run"
	einfo "/etc/init.d/hlds-dpb start"
	echo
	einfo "The server utilizes screen so you can get to"
	einfo "the console by typing:"
	einfo " screen -r hlds-dpb"
	echo
	einfo "To configure your server, just edit the file:"
	einfo "${GAMES_PREFIX_OPT}/halflife/dpb/server.cfg"
	einfo "For an example config file, use"
	einfo "/opt/halflife/dpb/server.cfg.sample"

	games_pkg_postinst
}
