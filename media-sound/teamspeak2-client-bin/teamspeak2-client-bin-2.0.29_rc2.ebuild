# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/teamspeak2-client-bin/teamspeak2-client-bin-2.0.29_rc2.ebuild,v 1.2 2003/09/07 00:06:06 msterret Exp $

DESCRIPTION="The Teamspeak Voice Communication Tool"
HOMEPAGE="http://www.teamspeak.org"
LICENSE="as-is"
KEYWORDS="~x86"

IUSE=""
SLOT="0"
S="${WORKDIR}/ts2_client_rc2_2029"
SRC_URI="ftp://ftp.teamspeak.org/releases/ts2_client_rc2_2029.tar.bz2"

DEPEND="virtual/x11
	virtual/glibc"
	#Note: ts2 client comes with its own speex packet, so there is no need
	#to install speex seperatly

src_unpack() {
		unpack ${A}
}

src_install() {
	mkdir -p ${D}usr/share/teamspeak2-client

	# Edit the Teamspeak startscript to match our install directory
	cp ${S}/setup.data/image/TeamSpeak ${S}/setup.data/image/TeamSpeak.tmp
	sed -e 's/%installdir%/\/usr\/share\/teamspeak2-client/g' \
		${S}/setup.data/image/TeamSpeak.tmp \
		> ${S}/setup.data/image/TeamSpeak
	rm ${S}/setup.data/image/TeamSpeak.tmp

	# Copy the files
	cp -r ${S}/setup.data/image/* ${D}usr/share/teamspeak2-client

	# Setup a sym-link to the binary
	insinto ${D}/usr/share/teamspeak2-client/
	dobin ${S}/setup.data/image/TeamSpeak
	dosym /usr/share/teamspeak2-client/TeamSpeak /usr/bin/TeamSpeak

}
pkg_postinst() {

        einfo
		einfo "Please Note: The new Teamspeak2 Release Candidate 2 Client"
		einfo "will not be able to connect to any of the *old* rc1 servers."
		einfo "if you get 'Bad response' from your server check if your"
		einfo "server is running rc2, which is a version >= 2.0.19.16."
		einfo "Also note this release supports the new speex codec, "
		einfo "so if you get unsupported codec messages, you need this :D"
		einfo
}
