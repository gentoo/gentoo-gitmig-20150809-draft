# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/pvpgn/pvpgn-1.6.5.ebuild,v 1.2 2004/09/01 05:37:08 mr_bones_ Exp $

inherit games

SUPPORTP="pvpgn-support-1.0"
DESCRIPTION="A gaming server for Battle.Net compatible clients"
HOMEPAGE="http://www.pvpgn.org/"
SRC_URI="mirror://sourceforge/pvpgn/${P}.tar.bz2
	mirror://sourceforge/pvpgn/${SUPPORTP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mysql postgres"

DEPEND="virtual/libc
	sys-libs/zlib
	mysql? ( >=dev-db/mysql-3.23 )
	postgres? ( >=dev-db/postgresql-7 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-fhs.patch"
}

src_compile() {
	cd src
	egamesconf \
		$(use_with mysql) \
		$(use_with postgres pgsql) \
		|| die
	emake || die "emake failed"
}

src_install() {
	dodoc README README.DEV CREDITS BUGS TODO UPDATE version-history.txt
	docinto docs
	dodoc docs/*

	cd src
	make DESTDIR="${D}" install || die "make install failed"

	insinto "${GAMES_DATADIR}/pvpgn"
	doins "${WORKDIR}/${SUPPORTP}/"* || die "doins failed"

	exeinto /etc/init.d
	local f
	for f in bnetd d2cs d2dbs ; do
		newexe "${FILESDIR}/init.d.rc" ${f}
		sed -i \
			-e "s:NAME:${f}:g" \
			-e "s:GAMES_BINDIR:${GAMES_BINDIR}:g" \
			-e "s:GAMES_USER:${GAMES_USER}:g" \
			-e "s:GAMES_GROUP:${GAMES_GROUP}:g" \
			"${D}/etc/init.d/${f}" \
			|| die "sed ${D}/etc/init.d/${f} failed"
	done

	prepgamesdirs
	keepdir "${GAMES_STATEDIR}/pvpgn/log"
	chown -R ${GAMES_USER}:${GAMES_GROUP} "${D}${GAMES_STATEDIR}/pvpgn"
	fperm 0755 "${GAMES_STATEDIR}/pvpgn/log"
	fperm 0750 "${GAMES_STATEDIR}/pvpgn"
}

pkg_postinst() {
	games_pkg_postinst

	einfo "  If this is a first installation you have to configure package by"
	einfo "editing the configuration files provided in \"${GAMES_SYSCONFDIR}/pvpgn\". Also you"
	einfo "should read the documentation from /usr/share/docs/${P}/"
	einfo
	einfo "  If you are upgrading you MUST read /usr/share/docs/${P}/UPDATE.gz"
	einfo "and update your configuration acordingly."
	if use mysql ; then
		echo
		einfo "  You have enabled MySQL storage support. You will need to edit "
		einfo "bnetd.conf to use it. Read README.storage from the docs dir."
	fi
	if use postgres ; then
		echo
		einfo "  You have enabled PostgreSQL storage support. You will need to edit "
		einfo "bnetd.conf to use it. Read README.storage from the docs dir."
	fi
}
