# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/teamspeak2-server-bin/teamspeak2-server-bin-2.0.19.40.ebuild,v 1.4 2004/04/01 08:34:47 eradicator Exp $

DESCRIPTION="The Teamspeak Voice Communication Server"
HOMEPAGE="http://www.teamspeak.org/"
SRC_URI="ftp://webpost.teamspeak.org/releases/ts2_server_rc2_${PV//./}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

S=${WORKDIR}/tss2_rc2

pkg_setup() {
	enewuser teamspeak2
}

src_install() {
	exeinto /opt/teamspeak2-server
	doexe server_linux sqlite.so

	touch ${D}/opt/teamspeak2-server/bad_names.txt
	fowners teamspeak2 /opt/teamspeak2-server/bad_names.txt

	insinto /opt/teamspeak2-server/sql
	doins sqlite_sql/*.sql
	insinto /opt/teamspeak2-server/http
	doins httpdocs/*.html
	insinto /opt/teamspeak2-server/http/gfx
	doins httpdocs/gfx/*.{png,gif}

	dodoc changelog.txt readme.txt slicense.txt

	exeinto /etc/init.d
	newexe ${FILESDIR}/teamspeak2-server.rc6 teamspeak2-server

	keepdir /var/{lib,log,run}/teamspeak2-server
	fowners teamspeak2 /var/{lib,log,run}/teamspeak2-server
	fperms 700 /var/{lib,log,run}/teamspeak2-server
}

pkg_postinst() {
	einfo
	einfo "The Teamspeak Server generates the admin and superadmin"
	einfo "passwords on the fly.  To get them, please look in:"
	einfo "/var/log/teamspeak2-server/server.log"
	einfo
}
