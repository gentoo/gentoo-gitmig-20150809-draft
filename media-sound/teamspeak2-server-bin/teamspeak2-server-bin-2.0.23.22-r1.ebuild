# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/teamspeak2-server-bin/teamspeak2-server-bin-2.0.23.22-r1.ebuild,v 1.2 2007/08/18 18:59:40 opfer Exp $

inherit eutils

# mjolnir - This is a necessary hack while we're waiting for an official
# 2.0.23.22 release.  We take the 2.0.23.19 release and overlay the 2.0.23.22
# binary on it.  When the real release comes out, we'll do an -r1 that uses
# the official release.
BASE_PV="2.0.23.19"

DESCRIPTION="The Teamspeak Voice Communication Server"
HOMEPAGE="http://www.goteamspeak.com/"
SRC_URI="ftp://ftp.freenet.de/pub/4players/teamspeak.org/releases/ts2_server_rc2_${BASE_PV//./}.tar.bz2
		mirror://gentoo/server_linux-${PVR//./}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE="mysql"

S="${WORKDIR}/tss2_rc2"

RDEPEND="amd64? ( >=sys-libs/glibc-2.3.4.20041102 )"
DEPEND=""

pkg_setup() {
	enewuser teamspeak2
}

src_install() {
	exeinto /opt/teamspeak2-server
	doexe server_linux sqlite.so
	if use mysql; then
		doexe libsqlmy.so
	fi

	touch "${D}"/opt/teamspeak2-server/bad_names.txt
	fowners teamspeak2 /opt/teamspeak2-server/bad_names.txt

	insinto /opt/teamspeak2-server/sql
	doins sqlite_sql/*.sql
	if use mysql; then
		insinto /opt/teamspeak2-server/mysql_sql
		doins mysql_sql/*.sql
	fi

	# www-data ...
	insinto /opt/teamspeak2-server/http
	doins httpdocs/*.html
	insinto /opt/teamspeak2-server/http/gfx
	doins httpdocs/gfx/*.{jpg,png,gif}
	insinto /opt/teamspeak2-server/http/help
	doins httpdocs/help/*.html

	# tcpquery docs ...
	insinto /opt/teamspeak2-server/tcpquerydocs
	doins tcpquerydocs/*.txt

	# user manual docs ...
	dodoc changelog.txt README
	dohtml manual.html
	dohtml -r Manual

	if use mysql; then
		dodoc INSTALL.mysql
	fi

	# runtime FS layout ...
	newinitd "${FILESDIR}/teamspeak2-server-ng.rc6" teamspeak2-server

	keepdir /{etc,var/{lib,log,run}}/teamspeak2-server
	fowners teamspeak2 /{etc,var/{lib,log,run}}/teamspeak2-server
	fperms 700 /{etc,var/{lib,log,run}}/teamspeak2-server

	# Fix bug #66639
	dosym sql /opt/teamspeak2-server/sqlite_sql
}

pkg_postinst() {
	einfo
	einfo "The Teamspeak Server generates the admin and superadmin"
	einfo "passwords on the fly.  To get them, please look in:"
	einfo "/var/log/teamspeak2-server/server.log"
	einfo
	if use mysql; then
		einfo "In order to have Teamspeak utilize a MySQL server, you will"
		einfo "need to edit the server.ini file found in /etc/teamspeak2-server/"
		einfo
		einfo "Also, please note Teamspeak is only compatible with MySQL 3.x"
		einfo "While it is possible to use a later version of MySQL, it may"
		einfo "require modifications such as replacing libraries."
		einfo
		einfo "For more information, please see INSTALL.mysql which is"
		einfo "located in /usr/share/doc/${PF}/ or "
		einfo "visit the Teamspeak website at http://www.teamspeak.org"
		einfo
	fi
}
