# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/wqy-zenhei/wqy-zenhei-0.6.26.ebuild,v 1.3 2009/01/14 00:39:13 josejx Exp $

inherit font

DESCRIPTION="WenQuanYi Hei-Ti Style (sans-serif) Chinese outline font"
HOMEPAGE="http://wqy.sourceforge.net/cgi-bin/enindex.cgi?ZenHei(en)"
SRC_URI="mirror://sourceforge/wqy/${P}-0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}
FONT_S=${S}
FONT_CONF=(	"44-wqy-zenhei.conf"
		"66-wqy-zenhei-sharp.conf"	)

FONT_SUFFIX="ttf"
DOCS="AUTHORS"

pkg_postinst() {
	font_pkg_postinst
	echo
	elog "This font installs two fontconfig configuration files."
	elog ""
	elog "To activate preferred rendering, run:"
	elog "eselect fontconfig enable 44-wqy-zenhei.conf"
	elog
	elog "To make the font only use embedded bitmap fonts when available, run:"
	elog "eselect fontconfig enable 66-wqy-zenhei-sharp.conf"
	echo
}
