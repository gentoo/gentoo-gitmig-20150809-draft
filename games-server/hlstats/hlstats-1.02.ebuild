# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/hlstats/hlstats-1.02.ebuild,v 1.2 2004/02/20 07:31:48 mr_bones_ Exp $

inherit games

DESCRIPTION="real-time player rankings/statistics for half-life"
HOMEPAGE="http://www.hlstats.org/"
SRC_URI="mirror://sourceforge/hlstats/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=sys-apps/sed-4"
RDEPEND="dev-lang/perl
	dev-db/mysql
	net-www/apache
	dev-php/mod_php"

src_install() {
	dohtml *.html
	dodoc ChangeLog

	insinto ${GAMES_LIBDIR}/${PN}
	doins *.{pm,plib}

	insinto ${GAMES_DATADIR}/${PN}
	doins *.sql

	sed -i \
		-e "s:./hlstats.conf:${GAMES_SYSCONFDIR}/hlstats.conf:" \
		-e "/^\$opt_libdir =/s:=.*:=\"${GAMES_LIBDIR}/${PN}/\";:" \
		*.pl
	dogamesbin *.pl
	dobin ${FILESDIR}/hlstats
	dosed "s:GENTOO_DIR:${GAMES_BINDIR}:" /usr/bin/hlstats
	exeinto /etc/init.d
	newexe ${FILESDIR}/hlstats.rc hlstats

	insinto ${GAMES_SYSCONFDIR}
	doins hlstats.conf

	dodir /home/httpd/htdocs
	cp -r hlstats.php hlstatsimg hlstatsinc ${D}/home/httpd/htdocs/

	#prepgamesdirs # let apache own the files
}

pkg_postinst() {
	einfo "To setup:"
	einfo " 1. \`mysqladmin create hlstats\`"
	einfo " 2. \`mysql hlstats < ${GAMES_DATADIR}/${PN}/hlstats.sql\`"
	einfo " 3. \`mysql hlstats < ${GAMES_DATADIR}/${PN}/gamesupport_GAME.sql\`"
	einfo "     so if you want cstrike support, replace 'GAME' with 'cstrike'"
	einfo " 4. Edit ${GAMES_SYSCONFDIR}/hlstats.conf"
	einfo " 5. Edit /home/httpd/htdocs/hlstats.php"
	einfo " 6. \`rc-update add hlstats default\`"
	einfo " 7. \`/etc/init.d/hlstats start\`"
	einfo " 8. Edit the cfg files of the game servers you want to track ..."
	einfo "     add these lines to your config file:"
	einfo "      log on"
	einfo "      logaddress 1.2.3.4 27500"
	einfo "      (replace 1.2.3.4 with the IP of the server hlstats is running on)"
	einfo " 9. If you want daily awards, setup a cronjob to run hlstats-awards.pl"
	einfo "     for example, run \`crontab -e\` and add this entry:"
	einfo "      30 00 * * *     ${GAMES_BINDIR}/hlstats-awards.pl"
	einfo " 10. Finally !  Start up the server and after a while goto"
	einfo "      http://1.2.3.4/hlstats.php"
	einfo "      (replace 1.2.3.4 with the IP of the server hlstats is running on)"
}
