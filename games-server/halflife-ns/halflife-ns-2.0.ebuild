# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/halflife-ns/halflife-ns-2.0.ebuild,v 1.3 2004/02/20 07:31:48 mr_bones_ Exp $

inherit games eutils

BASE=ns_v2_dedicated_server.zip
DESCRIPTION="Halflife Natural Selection mod ... kill aliens or marines"
HOMEPAGE="http://www.natural-selection.org/"
SRC_URI="http://gamefiles.blueyonder.co.uk/blueyondergames/halflife/modifications/naturalselection/server/win32/${BASE}
	http://gamefiles.blueyonder.co.uk/blueyondergames/halflife/modifications/naturalselection/server/win32/${BASE}
	http://www.clansin.com/Downloads/patches/server/${BASE}"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE="dedicated"

RDEPEND="games-server/halflife-server
	dedicated? ( app-misc/screen )"

S=${WORKDIR}/ns

src_unpack() {
	unpack ${BASE}
	cd ${S}
	edos2unix *.txt *.cfg *.gam *.lst
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/halflife
	dodir ${dir}

	mv ${S} ${D}/${dir}/ || die "moving ns"

	dogamesbin ${FILESDIR}/hlds-ns
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/hlds-ns

	exeinto /etc/init.d ; newexe ${FILESDIR}/hlds-ns.rc hlds-ns
	dosed "s:GENTOO_DIR:${GAMES_BINDIR}:" /etc/init.d/hlds-ns
	dosed "s:GENTOO_GAMES_USER:${GAMES_USER_DED}:" /etc/init.d/hlds-ns
	insinto /etc/conf.d ; newins ${FILESDIR}/hlds-ns.conf.d hlds-ns
	dosed "s:GENTOO_DIR:${dir}:" /etc/conf.d/hlds-ns

	local cdir=${GAMES_SYSCONFDIR}/halflife/ns
	dodir ${cdir}
	# this allows users to upgrade w/out losing their previous settings
	dir=${dir}/ns
	for cfg in *.cfg mapcycle.txt motd.txt titles.txt ; do
		[ -e ${dir}/ns/${cfg} ] && mv ${cfg}{,.sample}
		dosym {${dir},${cdir}}/${cfg}
	done

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	local dir=${GAMES_PREFIX_OPT}/halflife/ns
	touch ${dir}/{*.cfg,mapcycle.txt,motd.txt,titles.txt}

	einfo "To start the dedicated server, just run"
	einfo "/etc/init.d/hlds-ns start"
	echo
	einfo "The server utilizes screen so you can get to"
	einfo "the console by typing:"
	einfo " screen -r hlds-ns"
	echo
	einfo "To configure your server, just edit the file:"
	einfo "${GAMES_PREFIX_OPT}/halflife/ns/server.cfg"
}
