# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/teamspeak2-client-bin/teamspeak2-client-bin-2.0.32.60-r2.ebuild,v 1.6 2004/04/01 08:33:57 eradicator Exp $

MY_PV=rc2_2032
DESCRIPTION="The TeamSpeak voice communication tool"
HOMEPAGE="http://www.teamspeak.org"
SRC_URI="ftp://teamspeak.krawall.de/releases/ts2_client_${MY_PV}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~amd64"

IUSE="kde"

RDEPEND="virtual/x11"

DEPEND="${DEPEND}
	kde? ( >=kde-base/kdelibs-3.1.0 )
	imagemagick? ( media-gfx/imagemagick )
	amd64? ( app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs )"

S="${WORKDIR}/ts2_client_${MY_PV}/setup.data/image"

src_compile() {
	if use imagemagick; then
		convert icon.xpm teamspeak.png
	fi
}

src_install() {
	local dir="/opt/teamspeak2-client"

	newdoc Readme.txt README
	dodoc client_sdk/SDK_readme.txt
	dohtml manual/*

	into /opt
	dobin ${FILESDIR}/TeamSpeak
	dosed "s:%installdir%:/opt/teamspeak2-client:g" /opt/bin/TeamSpeak

	exeinto ${dir}
	doexe TeamSpeak.bin *.so*

	insinto ${dir}/sounds
	doins sounds/*

	insinto ${dir}/client_sdk
	exeinto ${dir}/client_sdk
	doins client_sdk/*.pas client_sdk/*.dpr
	doexe client_sdk/tsControl client_sdk/*.so*

	#Install the teamspeak icon.
	insinto /usr/share/pixmaps
	if use imagemagick; then
		doins teamspeak.png
	fi
	newins icon.xpm teamspeak.xpm

	if [ `use kde` ] ; then
		# Install a teamspeak.protocol file for kde/konqueror to accept
		# teamspeak:// links
		insinto $(kde-config --prefix)/share/services/
		doins ${FILESDIR}/teamspeak.protocol
	fi
}

pkg_postinst() {

	echo
	einfo
	einfo "Please Note: The new Teamspeak2 Release Candidate 2 Client"
	einfo "will not be able to connect to any of the *old* rc1 servers."
	einfo "if you get 'Bad response' from your server check if your"
	einfo "server is running rc2, which is a version >= 2.0.19.16."
	einfo "Also note this release supports the new speex codec, "
	einfo "so if you got unsupported codec messages, you need this :D"
	echo
	einfo "Note: If you just upgraded from a version less than 2.0.32.60-r1,"
	einfo "your users' config files will incorrectly point to non-existant"
	einfo "soundfiles because they've been moved from their old location."
	einfo "You may want to perform the following commands:"
	einfo "# mkdir /usr/share/teamspeak2-client"
	einfo "# ln -s ${dir}/sounds /usr/share/teamspeak2-client/sounds"
	einfo "This way, each user won't have to modify their config files to"
	einfo "reflect this move."
	echo
}

