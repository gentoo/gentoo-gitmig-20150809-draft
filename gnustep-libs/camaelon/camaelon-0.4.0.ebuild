# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/camaelon/camaelon-0.4.0.ebuild,v 1.1 2008/11/17 13:59:11 voyageur Exp $

inherit gnustep-2

S="${WORKDIR}/Etoile-${PV}/Bundles/${PN/c/C}"

DESCRIPTION="Camaelon allows you to load theme bundles for GNUstep."

HOMEPAGE="http://www.etoile-project.org"
SRC_URI="http://download.gna.org/etoile/etoile-${PV}.tar.gz"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

src_install() {
	gnustep-base_src_install

	#Link default theme
	dodir ${GNUSTEP_SYSTEM_LIBRARY}/Themes
	dosym ${GNUSTEP_SYSTEM_LIBRARY}/Bundles/Camaelon.themeEngine/Resources/Nesedah.theme ${GNUSTEP_SYSTEM_LIBRARY}/Themes/
}

gnustep_config_script() {
	echo "gnustep_append_default NSGlobalDomain GSAppKitUserBundles \"${GNUSTEP_SYSTEM_LIBRARY}/Bundles/Camaelon.themeEngine\""
	echo "gnustep_set_default Camaelon Theme Nesedah"
}
