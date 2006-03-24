# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-sidecandygmail/desklet-sidecandygmail-0.4.2.ebuild,v 1.4 2006/03/24 23:14:06 agriffis Exp $

inherit gdesklets

DESKLET_NAME="SideCandyGmail"

S=${WORKDIR}/${DESKLET_NAME}

DESCRIPTION="A desklet to check your gmail account"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=222"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${DESKLET_NAME}-${PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~ia64 ~ppc ~x86"

RDEPEND=">=gnome-extra/gdesklets-core-0.34.3"

src_unpack() {

	unpack ${A}

	# Fix the SideCandy issue in >0.35
	sed -i -e "s:<group id=\"slider\":<group id=\"slider\" width=\"5cm\":" ${S}/gmail.display

	# Remove spaces and apostrophes from folder names
	cd ${S}
	mv "icons-readme/Readme Files" "icons-readme/Readme_Files"
	mv "icons-readme/Readme_Files/FOOOD's-Icons-Logo.jpg" "icons-readme/Readme_Files/FOOODs-Icons-Logo.jpg"
	sed -i -e 's:Readme%20Files:Readme_Files:g' -e 's:FOOOD%27s:FOOODs:g' icons-readme/Readme.htm

}

src_install() {

	gdesklets_src_install

	dohtml -r ${S}/icons-readme

}
