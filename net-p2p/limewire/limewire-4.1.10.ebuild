# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/limewire/limewire-4.1.10.ebuild,v 1.1 2004/11/16 20:29:40 squinky86 Exp $

IUSE="gtk"
DESCRIPTION="Limewire Java Gnutella client"
HOMEPAGE="http://www.limewire.com"
SRC_URI="http://dev.gentoo.org/~squinky86/files/LimeWireLinux-${PV}.tgz"
LICENSE="GPL-2 Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
DEPEND="virtual/jre
	virtual/x11"
REDPEND="${DEPEND}
	gtk? ( >=x11-libs/gtk+-2.4 )"
S=${WORKDIR}
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
	einfo " To start LimeWire, run:"
	einfo "   $ limewire"
}
