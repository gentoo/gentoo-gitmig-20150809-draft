# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-psidisplays/desklet-psidisplays-20040420.ebuild,v 1.5 2004/11/11 20:31:53 blubb Exp $

MY_PN="PsiDisplayPackage"
MY_P=${MY_PN}-${PV}
S=${WORKDIR}

DESCRIPTION="A CPU Monitor Sensor for gdesklets"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=38"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ppc ~alpha ~amd64"

DEPEND=">=gnome-extra/gdesklets-core-0.26
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

