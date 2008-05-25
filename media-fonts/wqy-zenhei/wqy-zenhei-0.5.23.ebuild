# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/wqy-zenhei/wqy-zenhei-0.5.23.ebuild,v 1.1 2008/05/25 03:17:48 dirtyepic Exp $

inherit font

DESCRIPTION="WenQuanYi Hei-Ti Style (sans-serif) Chinese outline font"
HOMEPAGE="http://wqy.sourceforge.net/cgi-bin/enindex.cgi?ZenHei(en)"
SRC_URI="mirror://sourceforge/wqy/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}
FONT_S=${S}
FONT_CONF=( "44-wqy-zenhei.conf" )

FONT_SUFFIX="ttf"
DOCS="AUTHORS"

pkg_postinst() {
	font_pkg_postinst
	echo
	elog "This font installs a fontconfig configuration file.  To activate this"
	elog "configuration, run:"
	elog
	elog "	eselect fontconfig enable 44-wqy-zenhei.conf"
	elog
	echo
}
