# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/limewire/limewire-4.12.6.ebuild,v 1.1 2006/12/24 02:38:41 wltjr Exp $

inherit eutils

IUSE="gtk"
DESCRIPTION="Limewire Java Gnutella client"
HOMEPAGE="http://www.limewire.com"
SRC_URI="http://maverick.limewire.com/download/LimeWireOther.zip"
LICENSE="GPL-2 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="app-arch/unzip
	gtk? ( >=x11-libs/gtk+-2.4 )"

RDEPEND="virtual/jre"

S="${WORKDIR}/LimeWire"
PREFIX="/opt/limewire"

src_compile() {
	( echo \#!/bin/sh
	  echo cd ${PREFIX}
	  echo export J2SE_PREEMPTCLOSE=1
	  echo java -cp .:collections.jar:xerces.jar:jl011.jar:MessagesBundles.jar:themes.jar:logicrypto.jar:GURL.jar:LimeWire.jar com.limegroup.gnutella.gui.Main
	) >limewire.gentoo

	echo PATH=${PREFIX} > limewire.envd
}

src_install() {
	insinto	${PREFIX}
	doins *.jar *.war *.properties *.ver *.sh hashes *.txt
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
