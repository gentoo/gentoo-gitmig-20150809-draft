# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/darwin-streaming-server/darwin-streaming-server-5.0.1.1.ebuild,v 1.1 2004/03/25 00:15:44 eradicator Exp $

inherit eutils

MY_P="DarwinStreamingSrc${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Darwin Streaming Server allows you to send streaming media across the Internet using the industry standard RTP and RTSP protocols."
HOMEPAGE="http://developer.apple.com/darwin/projects/streaming/"
SRC_URI="http://www.opensource.apple.com/projects/streaming/release/${MY_P}.zip"
RESTRICT="fetch"

LICENSE="APSL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE="ssl"

DEPEND="virtual/glibc"

RDEPEND="${DEPEND}
	 dev-lang/perl
	 ssl? ( dev-perl/Net-SSLeay )"

DEPEND="${DEPEND}
	app-arch/unzip"

src_unpack() {
	unpack ${A}

	#Apply the patch to set proper FHS paths
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	#Run the included build script
	./Buildit || die
}

src_install() {
	#Binarys go in here 
	into /usr
	dosbin DarwinStreamingServer
	dobin PlaylistBroadcaster.tproj/PlaylistBroadcaster
	dobin MP3Broadcaster/MP3Broadcaster
	dobin qtpasswd.tproj/qtpasswd
	dobin WebAdmin/src/streamingadminserver.pl
	dobin StreamingProxy.tproj/StreamingProxy

	#StreamingServerModules go in here
	keepdir /usr/lib/dss

	#Configuration files go in here
	dodir /etc/dss
	insinto /etc/dss
	newins streamingserver.xml-POSIX streamingserver.xml
	newins streamingserver.xml-POSIX streamingserver.xml-sample
	doins relayconfig.xml-Sample
	doins qtusers
	doins qtgroups
	doins qtaccess
	doins WebAdmin/streamingadminserver.conf
	doins StreamingProxy.tproj/streamingproxy.conf
	newins WebAdmin/streamingadminserver.pem streamingadminserver.pem-sample

	#Server rc scripts go in here
	insinto /etc/init.d
	newins ${FILESDIR}/dss.rc dss
	chmod +x ${D}/etc/init.d/dss

	#Log files are generated in here
	keepdir /var/log/dss

	#The admin web application goes in here
	dodir /var/lib/dss
	cp -ax WebAdmin/WebAdminHtml ${D}/var/lib/dss/admin
	dodir /var/lib/dss/media
	cp -ax sample* ${D}/var/lib/dss/media
	keepdir /var/lib/dss/media/http
	keepdir /var/lib/dss/media/playlists

	#Documentation goes in here
	dodoc ReleaseNotes.txt
	dodoc Documentation/*
	dodoc StreamingProxy.tproj/StreamingProxy.html
}
