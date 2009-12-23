# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/teamspeak-client-bin/teamspeak-client-bin-3.0.0_beta5.ebuild,v 1.2 2009/12/23 11:43:25 trapni Exp $

# NOTE: The comments in this file are for instruction and documentation.
# They're not meant to appear with your final, production ebuild.  Please
# remember to remove them before submitting or committing your ebuild.  That
# doesn't mean you can't add your own comments though.

# The 'Header' on the third line should just be left alone.  When your ebuild
# will be committed to cvs, the details on that line will be automatically
# generated to contain the correct data.

EAPI=1

inherit eutils

DESCRIPTION="TeamSpeak Client - Voice Communication Software"
HOMEPAGE="http://teamspeak.com/"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="builtin-qt"
RESTRICT="strip"
PROPERTIES="interactive"

SRC_URI="
	amd64? ( http://ftp.4players.de/pub/hosted/ts3/releases/beta-5/TeamSpeak3-Client-linux_amd64-${PV/_/-}.run )
	x86? ( http://ftp.4players.de/pub/hosted/ts3/releases/beta-5/TeamSpeak3-Client-linux_x86-${PV/_/-}.run )
"

DEPEND="!builtin-qt? ( x11-libs/qt-core:4 x11-libs/qt-gui:4 )"
RDEPEND="${DEPEND}"

src_unpack() {
	for i in ${A}; do
		sh "${DISTDIR}/${i}" --target "${WORKDIR}" || die "unpack failed"
	done
}

src_install() {
	local dest="${D}/opt/teamspeak3-client"

	mkdir -p "${dest}"
	cp -R "${WORKDIR}/"* "${dest}/" || die

	exeinto /usr/bin
	doexe "${FILESDIR}/teamspeak3"

	mv "${dest}/ts3client_linux_"* "${dest}/ts3client"

	useq builtin-qt || rm "${dest}"/libQt*
}
