# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/perforce-gui/perforce-gui-2003.2.ebuild,v 1.4 2004/07/02 05:11:15 eradicator Exp $

DESCRIPTION="GUI for perforce version control system"
HOMEPAGE="http://www.perforce.com/"
SRC_URI="http://www.perforce.com/downloads/perforce/r03.2/bin.linux24x86/p4v.tgz"

LICENSE="perforce.pdf"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="nomirror nostrip"

DEPEND="virtual/libc"

S=${WORKDIR}

src_compile() {
	true
}

src_install() {
	dobin p4v
	mkdir -p ${D}/usr/share/doc/p4v-2003.2
	cp -R P4VResources/p4vhelp/* ${D}/usr/share/doc/p4v-2003.2/
}
