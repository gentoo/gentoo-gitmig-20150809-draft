# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythgame/mythgame-0.14.ebuild,v 1.1 2004/02/03 13:51:53 aliz Exp $

inherit flag-o-matic

DESCRIPTION="Game emulator module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="sys-libs/zlib
	>=sys-apps/sed-4
	|| ( >=media-tv/mythtv-${PV} >=media-tv/mythfrontend-${PV} )"

src_unpack() {
	unpack ${A}

	for i in `grep -lr "usr/local" "${S}"` ; do
		sed -e "s:/usr/local:/usr:g" -i "${i}" || die "sed failed"
	done
}

src_compile() {
	local cpu="`get-flag march || get-flag mcpu`"
	if [ "${cpu}" ] ; then
		sed -e "s:pentiumpro:${cpu}:g" -i "settings.pro" || die "sed failed"
	fi

	qmake -o "Makefile" "${PN}.pro"
	emake || die "compile problem"
}

src_install () {
	einstall INSTALL_ROOT="${D}"

	insinto "/usr/share/mythtv/database/${PN}"
	doins gamedb/*.sql

	dodoc README UPGRADING gamelist.xml
}

pkg_postinst() {
	einfo "If this is the first time you install MythGame,"
	einfo "you need to add /usr/share/mythtv/database/${PN}/metadata.sql"
	einfo "/usr/share/mythtv/database/${PN}/nesdb.sql and "
	einfo "/usr/share/mythtv/database/${PN}/snesdata.sql"
	einfo "to your MythTV database in that order."
	einfo
	einfo "You might run in this order:"
	einfo "'mysql < /usr/share/mythtv/database/${PN}/gamemetadata.sql'"
	einfo "'mysql < /usr/share/mythtv/database/${PN}/nesdb.sql'"
	einfo "'mysql < /usr/share/mythtv/database/${PN}/snesdata.sql'"
	einfo
	einfo "If you're upgrading from an older version and for more"
	einfo "setup and usage instructions, please refer to:"
	einfo "   /usr/share/doc/${PF}/README.gz"
	einfo "   /usr/share/doc/${PF}/UPGRADING.gz"
	ewarn "This part is important as there might be database changes"
	ewarn "which need to be performed or this package will not work"
	ewarn "properly."
	echo
}
