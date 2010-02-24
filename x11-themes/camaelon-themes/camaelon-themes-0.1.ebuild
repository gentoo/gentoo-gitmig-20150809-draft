# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/camaelon-themes/camaelon-themes-0.1.ebuild,v 1.2 2010/02/24 14:07:56 ssuominen Exp $

inherit gnustep-2

S=${WORKDIR}

DESCRIPTION="Additional themes for GNUstep Camaelon theme engine"
HOMEPAGE="http://www.etoile-project.org"
SRC_URI="http://brante.dyndns.org/gnustep/download/MaxCurve-0.2.tar.bz2
	mirror://sourceforge/mpdcon/IndustrialTheme.tar.bz2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

src_compile() { :; }

src_install() {
	egnustep_env

	#install themes
	dodir ${GNUSTEP_SYSTEM_LIBRARY}/Themes
	insinto ${GNUSTEP_SYSTEM_LIBRARY}/Themes/
	doins -r "${S}"/*theme
}
