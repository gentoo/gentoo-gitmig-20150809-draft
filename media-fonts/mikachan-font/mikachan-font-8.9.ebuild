# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mikachan-font/mikachan-font-8.9.ebuild,v 1.3 2004/02/04 00:19:33 augustus Exp $

IUSE=""

MY_PN="${PN/-/}"

DESCRIPTION="Mikachan Japanese TrueType fonts"
SRC_URI="mirror://sourceforge.jp/mikachan/5513/${MY_PN}-${PV}.tar.bz2
	mirror://sourceforge.jp/mikachan/5514/${MY_PN}P-${PV}.tar.bz2
	mirror://sourceforge.jp/mikachan/5515/${MY_PN}PB-${PV}.tar.bz2
	mirror://sourceforge.jp/mikachan/5516/${MY_PN}PS-${PV}.tar.bz2"
HOMEPAGE="http://mikachan-font.com/"

KEYWORDS="x86 alpha sparc ppc ~amd64"
LICENSE="free-noncomm"
SLOT="0"

DEPEND="virtual/x11"

S="${WORKDIR}"

FONTDIR="/usr/share/fonts/ttf/ja/mikachan/"

src_install () {
	insopts -m0644
	insinto ${FONTDIR}

	for f in "${MY_PN}" "${MY_PN}P" "${MY_PN}PB" "${MY_PN}PS" ; do
		cd ${WORKDIR}/${f}-${PV}
		doins  fonts/*.ttf
		newdoc COPYRIGHT	COPYRIGHT.${f}
		newdoc COPYRIGHT.ja	COPYRIGHT.ja.${f}
		newdoc README		README.${f}
		newdoc README.ja	README.ja.${f}
		newdoc ChangeLog	ChangeLog.${f}
	done

	mkfontscale ${D}/${FONTDIR}
	newins ${D}/${FONTDIR}/fonts.scale fonts.dir
	fc-cache ${D}/${FONTDIR}
}

pkg_postinst() {
	einfo "You need you add following line into 'Section \"Files\"' in"
	einfo "XF86Config and reboot X Window System, to use these fonts."
	einfo ""
	einfo "\t FontPath \"${FONTDIR}\""
	einfo ""
}

pkg_postrm(){
	einfo "You need you remove following line in 'Section \"Files\"' in"
	einfo "XF86Config, to unmerge this package completely."
	einfo ""
	einfo "\t FontPath \"${FONTDIR}\""
	einfo ""
}
