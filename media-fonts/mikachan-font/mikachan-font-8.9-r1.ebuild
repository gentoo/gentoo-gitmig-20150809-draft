# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mikachan-font/mikachan-font-8.9-r1.ebuild,v 1.3 2004/07/14 17:07:11 agriffis Exp $

inherit font

MY_PN="${PN/-/}"

DESCRIPTION="Mikachan Japanese TrueType fonts"
SRC_URI="mirror://sourceforge.jp/mikachan/5513/${MY_PN}-${PV}.tar.bz2
	mirror://sourceforge.jp/mikachan/5514/${MY_PN}P-${PV}.tar.bz2
	mirror://sourceforge.jp/mikachan/5515/${MY_PN}PB-${PV}.tar.bz2
	mirror://sourceforge.jp/mikachan/5516/${MY_PN}PS-${PV}.tar.bz2"
HOMEPAGE="http://mikachan-font.com/"

KEYWORDS="~x86 ~alpha ~sparc ~ppc ~amd64"
IUSE=""
LICENSE="free-noncomm"
SLOT="0"

S="${WORKDIR}"
FONT_S="${S}"
FONT_SUFFIX="ttf"

src_install () {

	insinto /usr/share/fonts/${PN}

	for f in "${MY_PN}" "${MY_PN}P" "${MY_PN}PB" "${MY_PN}PS" ; do
		cd ${WORKDIR}/${f}-${PV}
		doins  fonts/*.ttf
		newdoc COPYRIGHT	COPYRIGHT.${f}
		newdoc COPYRIGHT.ja	COPYRIGHT.ja.${f}
		newdoc README		README.${f}
		newdoc README.ja	README.ja.${f}
		newdoc ChangeLog	ChangeLog.${f}
	done

	font_xfont_config
	font_xft_config
}
