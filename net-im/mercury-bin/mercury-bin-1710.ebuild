# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/mercury-bin/mercury-bin-1710.ebuild,v 1.2 2005/12/29 00:17:49 humpback Exp $

inherit eutils java-pkg

MY_PVR=${PVR/rc/RC}

DESCRIPTION="MSN and Jabber client in Java"
HOMEPAGE="http://www.mercury.to/"

##Mercury.to does not provided http or ftp links so i provide here
SRC_URI="http://felisberto.net/~humpback/${MY_PVR}.zip"

LICENSE="mercury"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="nostrip"

##No webcam support, requires JNI files  that are only for x86
IUSE=""


DEPEND="app-arch/unzip
		>=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.5
		=dev-java/jgoodies-looks-1.3*
		dev-java/jdictrayapi
		dev-java/xpp3
		=dev-java/jdom-1.0"

S=${WORKDIR}

src_unpack() {
	unpack ${MY_PVR}.zip
	cd ${S}
	#rm -f *.dll *.so
	#Clean the dllStuff.jar from things we dont need
	#cd lib
	#mkdir dllStuff
	#cd dllStuff
	#unzip ../dllStuff.jar
#	rm -rf ../dllStuff.jar org/jdesktop x10gimli com/jeans
	#rm -rf ../dllStuff.jar x10gimli com/jeans # Problems with jdictrayapi in amd64
	# it looks to me that one can use the .so file that comes with the package
	# but not the one in portage
	#cd ${S}
	rm lib/jdom1_0.jar # jdom
	#rm lib/JFlash.jar # seems to be trial from http://www.javaapis.com/jflashplayer/
					#which says its windows only
	rm lib/xmlpull.jar # xpp3
}

src_install() {
	#rebuild the dllStuff.jar
	#cd ${S}/lib/dllStuff
	#jar cf ../dllStuff.jar *
	#cd ${S}
	#rm -rf lib/dllStuff

	#Start installing stuff
	insinto /opt/${PN}/resources
	doins -r resources/*
	dojar lib/*


	insinto /usr/share/pixmaps
	newins  ${FILESDIR}/icon32.gif mercury.gif

	exeinto /opt/bin
	newexe ${FILESDIR}/mercury.sh mercury

	make_desktop_entry mercury "Mercury MSN client" /usr/share/pixmaps/mercury.gif

	# Adding env.d LDPATH setting to prevent a Mercury bug
	echo 'LDPATH="/opt/mercury-bin"' > 30mercury
	doenvd 30mercury
}
