# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/pvpgn/pvpgn-1.8.0.ebuild,v 1.3 2007/02/07 14:10:49 nyhm Exp $

inherit eutils games

SUPPORTP="pvpgn-support-1.0"
DESCRIPTION="A gaming server for Battle.Net compatible clients"
HOMEPAGE="http://pvpgn.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${PN}-${PV/_/}.tar.bz2
	mirror://berlios/${PN}/${SUPPORTP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="mysql postgres"

DEPEND="mysql? ( virtual/mysql )
	postgres? ( >=dev-db/postgresql-7 )"

S=${WORKDIR}/${PN}-${PV/_/}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PV}-fhs.patch"
}

src_compile() {
	cd src
	# everything in GAMES_BINDIR (bug #63071)
	egamesconf \
		--sbindir="${GAMES_BINDIR}" \
		$(use_with mysql) \
		$(use_with postgres pgsql) \
		|| die
	emake || die "emake failed"
}

src_install() {
	local f

	dodoc README README.DEV CREDITS BUGS TODO UPDATE version-history.txt
	docinto docs
	dodoc docs/*

	cd src
	emake DESTDIR="${D}" install || die "emake install failed"

	insinto "${GAMES_DATADIR}/pvpgn"
	doins "${WORKDIR}/${SUPPORTP}/"* || die "doins failed"

	# GAMES_USER_DED here instead of GAMES_USER (bug #65423)
	for f in bnetd d2cs d2dbs ; do
		newinitd "${FILESDIR}/init.d.rc" ${f}
		sed -i \
			-e "s:NAME:${f}:g" \
			-e "s:GAMES_BINDIR:${GAMES_BINDIR}:g" \
			-e "s:GAMES_USER:${GAMES_USER_DED}:g" \
			-e "s:GAMES_GROUP:${GAMES_GROUP}:g" \
			"${D}/etc/init.d/${f}" \
			|| die "sed failed"
	done

	prepgamesdirs
	keepdir "${GAMES_STATEDIR}/pvpgn/log"
	chown -R ${GAMES_USER_DED}:${GAMES_GROUP} "${D}${GAMES_STATEDIR}/pvpgn"
	fperms 0775 "${GAMES_STATEDIR}/pvpgn/log"
	fperms 0770 "${GAMES_STATEDIR}/pvpgn"
}

pkg_postinst() {
	games_pkg_postinst

	einfo "  If this is a first installation you have to configure package by"
	einfo "editing the configuration files provided in \"${GAMES_SYSCONFDIR}/pvpgn\". Also you"
	einfo "should read the documentation from /usr/share/docs/${PF}/"
	einfo
	einfo "  If you are upgrading you MUST read /usr/share/docs/${PF}/UPDATE.gz"
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
