# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/teamspeak2-client-bin/teamspeak2-client-bin-2.0.32.60-r1.ebuild,v 1.2 2004/03/01 05:37:16 eradicator Exp $

MY_PV=rc2_2032
DESCRIPTION="The Teamspeak Voice Communication Tool"
HOMEPAGE="http://www.teamspeak.org/"
SRC_URI="ftp://teamspeak.krawall.de/releases/ts2_client_${MY_PV}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/x11
	media-libs/jpeg
	virtual/glibc"

S=${WORKDIR}/ts2_client_${MY_PV}

src_install() {
	dodir /opt/teamspeak2-client

	cp -r setup.data/image/* ${D}/opt/teamspeak2-client/
	rm ${D}/opt/teamspeak2-client/TeamSpeak

	into /opt
	dobin ${FILESDIR}/TeamSpeak
	dosed "s:%installdir%:/opt/teamspeak2-client:g" /opt/bin/TeamSpeak
}

pkg_postinst() {
	einfo
	einfo "Please Note: The new Teamspeak2 Release Candidate 2 Client"
	einfo "will not be able to connect to any of the *old* rc1 servers."
	einfo "if you get 'Bad response' from your server check if your"
	einfo "server is running rc2, which is a version >= 2.0.19.16."
	einfo "Also note this release supports the new speex codec, "
	einfo "so if you got unsupported codec messages, you need this :D"
	einfo
}
