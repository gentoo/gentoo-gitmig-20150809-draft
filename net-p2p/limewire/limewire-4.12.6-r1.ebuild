# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/limewire/limewire-4.12.6-r1.ebuild,v 1.1 2007/01/02 19:52:16 wltjr Exp $

inherit eutils java-pkg-2

IUSE="gtk"
DESCRIPTION="Limewire Java Gnutella client"
HOMEPAGE="http://www.limewire.com"
SRC_URI="http://maverick.limewire.com/download/LimeWireOther.zip"
LICENSE="GPL-2 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="app-arch/unzip
	dev-java/commons-logging
	dev-java/commons-net
	dev-java/icu4j
	dev-java/log4j
	=dev-java/xerces-1.3*
	dev-java/xml-commons-external
	gtk? ( >=x11-libs/gtk+-2.4 )"

RDEPEND="virtual/jre"

S="${WORKDIR}/LimeWire"
PREFIX="/opt/limewire"

src_compile() {
	( echo \#!/bin/sh
	  echo cd ${PREFIX}
	  echo export J2SE_PREEMPTCLOSE=1
	  echo java -cp .:collections.jar:xerces.jar:jl011.jar:MessagesBundles.jar:themes.jar:logicrypto.jar:GURL.jar:LimeWire.jar com.limegroup.gnutella.gui.Main
	) > limewire.gentoo

	echo PATH=${PREFIX} > limewire.envd

	sed -i -e 's:icu4j.jar=2EA7BE7FE723AE4A7BB99850238CE7DE::' \
		-e 's:xerces.jar=F192FC03C1DFEB0C20A26EDF1D5E04DF::' \
		"${S}/hashes" || die "Could not modify hashes file"

}

src_install() {
	insinto	${PREFIX}
	doins *.jar *.war *.properties *.ver hashes *.sh *.txt

	# Replace bundled jars, don't replace commons-httpclient!
	cd "${D}/opt/limewire"
	java-pkg_jar-from commons-logging commons-logging.jar
	java-pkg_jar-from commons-net commons-net.jar
	java-pkg_jar-from icu4j icu4j.jar
	java-pkg_jar-from log4j log4j.jar
	java-pkg_jar-from xerces-1.3 xerces.jar
	java-pkg_jar-from xml-commons-external-1.3 xml-apis.jar

	cd "${S}"
	exeinto /usr/bin
	newexe limewire.gentoo limewire

	newenvd limewire.envd 99limewire

	insinto /usr/share/icons/hicolor/32x32/apps
	newins "${FILESDIR}"/main-icon.png limewire.png

	make_desktop_entry limewire LimeWire
}

pkg_postinst() {
	use gtk || ewarn "You will probably not be able to use the gtk frontend."
	einfo " Finished installing LimeWire into ${PREFIX}"
}
