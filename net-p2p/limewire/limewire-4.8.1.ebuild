# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/limewire/limewire-4.8.1.ebuild,v 1.1 2005/03/22 07:33:50 sekretarz Exp $

IUSE="gtk"
DESCRIPTION="Limewire Java Gnutella client"
HOMEPAGE="http://www.limewire.com"
SRC_URI="http://dev.gentoo.org/~sekretarz/distfiles/LimeWireOther-${PV}.zip"
LICENSE="GPL-2 Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
DEPEND="app-arch/unzip"
RDEPEND="virtual/jre
	virtual/x11
	gtk? ( >=x11-libs/gtk+-2.4 )"
S=${WORKDIR}/LimeWire
PREFIX="/opt/limewire"

src_compile() {
	( echo \#!/bin/sh
	  echo cd ${PREFIX}
	  echo java -cp .:collections.jar:xerces.jar:jl011.jar:MessagesBundles.jar:themes.jar:logicrypto.jar:GURL.jar com.limegroup.gnutella.gui.Main
	  echo export J2SE_PREEMPTCLOSE=1
	  echo java -jar LimeWire.jar
	) >limewire.gentoo

	echo PATH=${PREFIX} >99limewire
}

src_install() {
	insinto	${PREFIX}
	doins *.jar *.war *.properties *.ver *.sh hashes *.txt
	exeinto /usr/bin
	newexe limewire.gentoo limewire
	insinto	/etc/env.d
	doins	99limewire
	insinto /usr/share/applications
	doins ${FILESDIR}/limewire.desktop
	insinto /usr/share/pixmaps/limewire
	doins ${FILESDIR}/main-icon.png
}
pkg_postinst() {
	use gtk || ewarn "You will probably not be able to use the gtk frontend."
	einfo " Finished installing LimeWire into ${PREFIX}"
}
