# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/g2gui/g2gui-0.3.0_pre1.ebuild,v 1.5 2004/07/17 15:46:06 squinky86 Exp $

MY_P=${P/_/-}-linux-jar-gtk
S=${WORKDIR}/${MY_P}

DESCRIPTION="The 2nd generation gui for the universal p2p-client mldonkey"
HOMEPAGE="http://developer.berlios.de/projects/mldonkey/"
SRC_URI="http://download.berlios.de/mldonkey/${MY_P}.tar.bz2"
LICENSE="GPL-2 CPL-1.0"
KEYWORDS="x86 ~ppc"
IUSE=""
SLOT="0"
DEPEND=">=sys-apps/sed-4"
RDEPEND="virtual/jdk"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:cd $(dirname $0):cd /usr/share/g2gui:g' g2gui
}

src_compile() {
	if [ -z "$JAVA_HOME" ]; then
		einfo
		einfo "\$JAVA_HOME not set!"
		einfo "Please use java-config to configure your JVM and try again."
		einfo
		die "\$JAVA_HOME not set."
	fi
}

src_install () {
	dodir /usr/share/g2gui
	dodir /usr/bin
	cd ${WORKDIR}/${P/_/-}-linux-jar-gtk
	cp -R g2gui distrib g2submit lib ${D}/usr/share/g2gui
	cd ${D}/usr/share/g2gui
	chmod -R u+rw,ug-s,go+u,go-w distrib g2submit lib
	chmod 755 ${D}/usr/share/g2gui/g2gui
	dosym ${D}/usr/share/g2gui/g2gui /usr/bin/g2gui
}
