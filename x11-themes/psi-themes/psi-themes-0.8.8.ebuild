# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/psi-themes/psi-themes-0.8.8.ebuild,v 1.2 2004/03/01 14:00:45 humpback Exp $

SRC_URI="http://psi.sourceforge.net/files/common/iconsets/beos/beos.zip
	http://psi.sourceforge.net/files/common/iconsets/cosmic/cosmic.zip
	http://psi.sourceforge.net/files/common/iconsets/gabber/gabber.zip
	http://psi.sourceforge.net/files/common/iconsets/icq2/icq2.zip
	http://psi.sourceforge.net/files/common/iconsets/licq/licq.zip
	http://psi.sourceforge.net/files/common/iconsets/mike/mike.zip
	http://psi.sourceforge.net/files/common/iconsets/smiley/smiley.zip
	http://psi.sourceforge.net/files/common/iconsets/psi_dudes/psi_dudes.zip
	http://psi.sourceforge.net/files/common/iconsets/aqualight/aqualight.zip
	http://psi.sourceforge.net/files/common/iconsets/businessblack/businessblack.zip
	http://psi.sourceforge.net/files/common/iconsets/bluekeramik/bluekeramik.zip
	http://psi.sourceforge.net/files/common/iconsets/aquaploum/aquaploum.zip
	http://psi.sourceforge.net/files/common/iconsets/thomas/thomas.zip
	http://psi.sourceforge.net/files/common/iconsets/crystal/crystal.zip
	http://psi.sourceforge.net/files/common/iconsets/jilly/jilly.zip

	"
DESCRIPTION="Iconsets for Psi, a QT 3.x Jabber Client"
HOMEPAGE="http://psi.affinix.com/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="<=net-im/psi-0.9
	app-arch/unzip"

S=${WORKDIR}

src_unpack() {
	for FILE in ${A}; do
		DIR=$( basename ${FILE} .zip )
		unpack ${FILE}
		mkdir ${DIR} 2>/dev/null
		mv desc *.png* ${DIR} 2>/dev/null
		chmod -R 0644 ${DIR}/* 2>/dev/null
	done
}

src_install() {
	dodir /usr/share/psi/iconsets
	mv * ${D}/usr/share/psi/iconsets/
}

