# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/psi-themes/psi-themes-0.8.7.ebuild,v 1.1 2002/11/03 15:15:28 verwilst Exp $

S=${WORKDIR}/${P}
SRC_URI="http://psi.sourceforge.net/files/common/iconsets/beos/beos.zip
http://psi.sourceforge.net/files/common/iconsets/cosmic/cosmic.zip
http://psi.sourceforge.net/files/common/iconsets/gabber/gabber.zip
http://psi.sourceforge.net/files/common/iconsets/icq2/icq2.zip
http://psi.sourceforge.net/files/common/iconsets/licq/licq.zip
http://psi.sourceforge.net/files/common/iconsets/mike/mike.zip
http://psi.sourceforge.net/files/common/iconsets/smiley/smiley.zip"

DESCRIPTION="Iconsets for Psi, a QT 3.x Jabber Client"
HOMEPAGE="http://psi.affinix.com"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=net-im/psi-0.8.7
	app-arch/unzip"

SETS="beos cosmic gabber icq2 licq mike smiley"

src_unpack() {
	
for x in ${SETS}; do
	cp ${DISTDIR}/${x}.zip ${WORKDIR}
	unzip ${WORKDIR}/${x}.zip
done

}

src_install() {

	mkdir -p ${D}/usr/share/psi/iconsets
	
	for x in ${SETS}; do
		cp -r ${WORKDIR}/${x} ${D}/usr/share/psi/iconsets/
	done
}
