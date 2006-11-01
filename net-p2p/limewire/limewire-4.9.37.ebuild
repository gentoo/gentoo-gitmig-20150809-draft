# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/limewire/limewire-4.9.37.ebuild,v 1.4 2006/11/01 20:04:40 wolf31o2 Exp $

inherit eutils

IUSE="gtk"
DESCRIPTION="Limewire Java Gnutella client"
HOMEPAGE="http://www.limewire.com"
SRC_URI="http://dev.gentoo.org/~sekretarz/distfiles/LimeWireOther-${PV}.zip"
LICENSE="GPL-2 Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
DEPEND="app-arch/unzip
	gtk? ( >=x11-libs/gtk+-2.4 )"

RDEPEND="virtual/jre
	virtual/jdk"

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
