# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gdeskcal-skins/gdeskcal-skins-0.0.1.ebuild,v 1.2 2005/07/01 04:41:36 josejx Exp $

S=${WORKDIR}
DESCRIPTION="Collection of gdeskcal skins"
HOMEPAGE="http://www.pycage.de/software_gdeskcal.html"
THEME_URI="http://www.pycage.de/download/skins/gdeskcal"
SRC_URI="${THEME_URI}/yellow.tar.gz
	${THEME_URI}/simplisme.tar.gz
	${THEME_URI}/LTVCalendar.tar.gz
	${THEME_URI}/tombo.tar.gz
	${THEME_URI}/aqua.tar.gz
	${THEME_URI}/clearlemon.tar.gz
	${THEME_URI}/august_big.tar.gz
	${THEME_URI}/XFCE.tar.gz
	${THEME_URI}/august.tar.gz
	${THEME_URI}/gorillerat.tar.gz
	${THEME_URI}/grey_skin.tar.gz
	${THEME_URI}/gnometheme.tar.gz
	${THEME_URI}/SimpleForDark.tar.gz
	${THEME_URI}/e_01.tar.gz
	${THEME_URI}/miderat_RTL.tar.gz
	${THEME_URI}/light_01.tar.gz
	${THEME_URI}/light_02.tar.gz
	${THEME_URI}/tnf.tar.gz
	${THEME_URI}/redskin.tar.gz
	${THEME_URI}/tiny_and_simple.tar.gz
	${THEME_URI}/LCD.tar.gz"

SLOT="0"
LICENSE="freedist"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="x11-misc/gdeskcal"

src_install() {
	dodir /usr/share/gdeskcal/skins
	cp -dR * ${D}/usr/share/gdeskcal/skins
	chown -R root:root ${D}/usr/share/gdeskcal/skins
	chmod -R o-w ${D}/usr/share/gdeskcal/skins
	chmod -R a+rX ${D}/usr/share/gdeskcal/skins
}
