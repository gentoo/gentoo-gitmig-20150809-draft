# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/halflife-ns/halflife-ns-3.0_beta3.ebuild,v 1.1 2004/04/16 18:21:34 vapier Exp $

inherit games eutils

BASE=ns_v3_b1_dedicated_server.zip
PATCH=ns_v30_b3_patch_dedicated_server.zip
DESCRIPTION="Halflife Natural Selection mod ... kill aliens or marines"
HOMEPAGE="http://www.natural-selection.org/"
SRC_URI="http://download.jarhedz.com/ns_beta/${BASE}
	ftp://ftp.snt.utwente.nl/pub/games/halflife/steam/natural-selection/server/${BASE}
	ftp://games.surftown.dk/ns/beta-3.0/${PATCH}
	http://ftp.club-internet.fr/pub/games/nofrag/ns-fr.com/server/${PATCH}"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE="dedicated"

RDEPEND="games-server/halflife-server
	dedicated? ( app-misc/screen )"

S=${WORKDIR}/nsp

src_unpack() {
	unpack ${BASE}
	unpack ${PATCH}
	cd ${S}
	edos2unix *.txt *.cfg *.gam *.lst
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/halflife
	dodir ${dir}

	mv ${S} ${D}/${dir}/ || die "moving nsp"

	newgamesbin ${FILESDIR}/hlds-ns hlds-nsp
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/hlds-nsp
	dosed "s:-game ns:-game nsp:" ${GAMES_BINDIR}/hlds-nsp

	exeinto /etc/init.d ; newexe ${FILESDIR}/hlds-ns.rc hlds-nsp
	dosed "s:GENTOO_DIR:${GAMES_BINDIR}:" /etc/init.d/hlds-nsp
	dosed "s:GENTOO_GAMES_USER:${GAMES_USER_DED}:" /etc/init.d/hlds-nsp
	dosed "s:hlds-ns:hlds-nsp:" /etc/init.d/hlds-nsp
	insinto /etc/conf.d ; newins ${FILESDIR}/hlds-ns.conf.d hlds-nsp
	dosed "s:GENTOO_DIR:${dir}:" /etc/conf.d/hlds-nsp

	local cdir=${GAMES_SYSCONFDIR}/halflife/nsp
	dodir ${cdir}
	# this allows users to upgrade w/out losing their previous settings
	dir=${dir}/nsp
	for cfg in *.cfg mapcycle.txt motd.txt titles.txt ; do
		[ -e ${dir}/nsp/${cfg} ] && mv ${cfg}{,.sample}
		dosym {${dir},${cdir}}/${cfg}
	done

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	local dir=${GAMES_PREFIX_OPT}/halflife/nsp
	touch ${dir}/{*.cfg,mapcycle.txt,motd.txt,titles.txt}

	einfo "To start the dedicated server, just run"
	einfo "/etc/init.d/hlds-nsp start"
	echo
	einfo "The server utilizes screen so you can get to"
	einfo "the console by typing:"
	einfo " screen -r hlds-nsp"
	echo
	einfo "To configure your server, just edit the file:"
	einfo "${GAMES_PREFIX_OPT}/halflife/nsp/server.cfg"
}
