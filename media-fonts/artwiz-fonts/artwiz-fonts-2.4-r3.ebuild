# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/artwiz-fonts/artwiz-fonts-2.4-r3.ebuild,v 1.14 2007/10/02 01:39:56 dirtyepic Exp $

inherit font font-ebdftopcf

MY_PN="xfonts-artwiz"
S="${WORKDIR}/${MY_PN}-2.3"
DESCRIPTION="Artwiz Fonts"
SRC_URI="mirror://debian/pool/main/${MY_PN:0:1}/${MY_PN}/${MY_PN}_${PV}.tar.gz"
HOMEPAGE="http://fluxbox.sourceforge.net/docs/artwiz-fonts.php"

SLOT=0
LICENSE="ZBL"
KEYWORDS="~mips"
IUSE=""

FONT_PN="artwiz"
FONTDIR="/usr/share/fonts/${FONT_PN}"
FONT_S="${S}/upstream"
FONT_SUFFIX="pcf.gz"

src_unpack() {
	unpack ${A}
	# we don't want this
	# clean it out here so we don't build it to a pcf
	rm -f ${FONT_S}/cursor.{pcf.gz,pcf,bdf}
}

src_compile() {
	cd ${FONT_S}
	font-ebdftopcf_src_compile
}

src_install() {
	font_src_install
	doins ${S}/debian/fonts.alias

	if [ -f ${ROOT}/etc/X11/fs/config -a -z "$(grep artwiz /etc/X11/fs/config)" ]
	then
		sed 's#^catalog.*$#&\n\t/usr/share/fonts/artwiz:unscaled,#g' \
			/etc/X11/fs/config > ${T}/config
		insinto /etc/X11/fs
		doins ${T}/config
	fi
}
