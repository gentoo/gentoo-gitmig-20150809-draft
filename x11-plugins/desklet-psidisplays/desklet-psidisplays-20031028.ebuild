# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-psidisplays/desklet-psidisplays-20031028.ebuild,v 1.2 2004/04/05 03:26:53 agriffis Exp $

MY_PN="PsiDisplayPackage"
MY_P=${MY_PN}-${PV}
S=${WORKDIR}

DESCRIPTION="A CPU Monitor Sensor for gdesklets"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.bz2"
HOMEPAGE="http://www.pycage.de/"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc ~alpha"

DEPEND=">=gnome-extra/gdesklets-core-0.23
	>=x11-plugins/desklet-psisensors-${PV}
	>=x11-plugins/desklet-clock-0.32"

DOCS="README"

src_install()  {

	SYS_PATH="/usr/share/gdesklets"
	dodir ${SYS_PATH}/Displays

	insinto ${SYS_PATH}/Displays/${PN/2*/}
	doins ${S}/psi-displays-v0.2/*.display
	# removing MemoOver for now, as in corresponding psisensors
	# ebuild
	rm ${D}${SYS_PATH}/Displays/${PN/2*/}/memoover.display
	cp -R ${S}/Themes ${D}${SYS_PATH}/

	dodoc ${S}/${DOCS}

}

