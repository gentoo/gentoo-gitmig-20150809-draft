# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/psi-themes/psi-themes-0.8.7.ebuild,v 1.4 2004/03/01 14:00:45 humpback Exp $

SRC_URI="http://psi.sourceforge.net/files/common/iconsets/beos/beos.zip
	http://psi.sourceforge.net/files/common/iconsets/cosmic/cosmic.zip
	http://psi.sourceforge.net/files/common/iconsets/gabber/gabber.zip
	http://psi.sourceforge.net/files/common/iconsets/icq2/icq2.zip
	http://psi.sourceforge.net/files/common/iconsets/licq/licq.zip
	http://psi.sourceforge.net/files/common/iconsets/mike/mike.zip
	http://psi.sourceforge.net/files/common/iconsets/smiley/smiley.zip"
DESCRIPTION="Iconsets for Psi, a QT 3.x Jabber Client"
HOMEPAGE="http://psi.affinix.com/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="<=net-im/psi-0.9.0
	app-arch/unzip"

S=${WORKDIR}

src_install() {
	dodir /usr/share/psi/iconsets
	mv * ${D}/usr/share/psi/iconsets/
}
